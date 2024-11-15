{
  ####################################################################################################################
  Obs:
  - Código aberto a comunidade Delphi, desde que mantenha os dados dos autores e mantendo sempre o nome do IDEALIZADOR
  Marcelo dos Santos de Oliveira;

  ####################################################################################################################
  Evolução do Código
  ####################################################################################################################
  Autor........: Marcelo Oliveira
  Email........: marcelo.broz@hotmail.com
  Data.........: 15/11/2024
  Identificador: @Marcelo
  Modificação..:
  ####################################################################################################################
}
unit uTypebotAPI;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient,
  System.Net.URLClient, IdSSLOpenSSL, IdHTTP,
  uRetMensagemApiOficial, StrUtils, Horse, Horse.Commons, Horse.Core,
  web.WebBroker,
  RESTRequest4D, REST.Types, REST.Client, System.Net.Mime,
  uTTypebotAPI.Emoticons;

type
  { Events }
  TOnRetSendMessage = Procedure(Sender: TObject; Response: string) of object;
  TResponseEvent = Procedure(Sender: TObject; Response: string) of object;

  TTypebotAPI = class(TComponent)

  private
    FOnRetSendMessage: TOnRetSendMessage;
    FOnResponse: TResponseEvent;

    FEmoticons: TTypebotAPIEmoticons;
    FUrlTypebot: string;
    function CaractersWeb(vText: string): string;

  protected

  public

    function StartChat(publicId: string; textBubbleContentFormat: string; var response: string): string;
    function ContinueChat(sessionId, TextMessage: string; var response: string): string;

    function GetContentTypeFromDataUri(const ADataUri: string): string;
    function GetContentTypeFromExtension(const AContentType: string): string;
    function GetExtensionTypeFromContentType(const AFileExtension
      : string): string;
    function GetTypeFileFromContentType(const AContentType: string): string;

    procedure StartServer;
    procedure StopServer;

  published
    property UrlTypebot: string read FUrlTypebot write FUrlTypebot;
    property OnRetSendMessage: TOnRetSendMessage read FOnRetSendMessage
      write FOnRetSendMessage;
    property OnResponse: TResponseEvent read FOnResponse write FOnResponse;
    Property Emoticons: TTypebotAPIEmoticons read FEmoticons write FEmoticons;
  end;

procedure Register;

implementation

uses
  uTypebotResponseStartChat, uTypeBotResponseContinueChat;

//{$R 'Typebot4Delphi.res'} // Adicione esta linha para referenciar o arquivo de recurso

procedure Register;
begin
  RegisterComponents('TypebotAPI', [TTypebotAPI]);
end;

{ TTypebotAPI }

function TTypebotAPI.CaractersWeb(vText: string): string;
begin
  vText := StringReplace(vText, sLineBreak, ' \n', [rfReplaceAll]);
  vText := StringReplace(vText, '<br>', ' \n', [rfReplaceAll]);
  vText := StringReplace(vText, '<br />', ' \n', [rfReplaceAll]);
  vText := StringReplace(vText, '<br/>', ' \n', [rfReplaceAll]);
  vText := StringReplace(vText, #13, '', [rfReplaceAll]);
  vText := StringReplace(vText, '\r', '', [rfReplaceAll]);
  vText := StringReplace(vText, '"', '\"', [rfReplaceAll]);
  vText := StringReplace(vText, #$A, ' \n', [rfReplaceAll]);
  vText := StringReplace(vText, #$A#$A, ' \n', [rfReplaceAll]);
  Result := vText;
end;

function TTypebotAPI.StartChat(publicId, textBubbleContentFormat: string; var response: string): string;
var
  JSON: string;
  ResultTypebotStartChat: uTypebotResponseStartChat.
    TResultTypeBotStartChatClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try

    if textBubbleContentFormat = '' then
      textBubbleContentFormat := 'richText';

    JSON := '{ ' + '  "textBubbleContentFormat": "' + textBubbleContentFormat +'" ' + '}';

    UTF8Texto := UTF8Encode(JSON);

    try
      Response := TRequest.New.BaseURL(UrlTypebot + '/api/v1/typebots/' + publicId + '/startChat')
      // http://172.23.148.194:3002/api/v1/typebots/my-typebot-vu8p5jy/startChat
        .ContentType('application/json')
      // .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto).Post.Content;

    except
      on E: Exception do
      begin
        if Assigned(FOnRetSendMessage) then
          FOnRetSendMessage(Self, Response + 'Error: ' + E.Message);

        Result := 'Failed';
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

    except
      on E: Exception do
    end;

    try
      ResultTypebotStartChat := uTypebotResponseStartChat.TResultTypeBotStartChatClass.FromJsonString(Response);
      Result := ResultTypebotStartChat.sessionId;

    except
      on E: Exception do
      begin
        Result := 'Failed';
        Exit;
      end;
    end;

  finally
  end;
end;

procedure TTypebotAPI.StartServer;
begin
  (* THorse
    .Post('/responsewebhook',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
    Response: string;
    begin
    Response := 'save response webhook ok';
    Res.Send(Response);

    Response := Req.Body;
    if Assigned(FOnResponse) then
    FOnResponse(Self, Response);
    end
    );

    THorse
    .Post('/responseinstagram',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
    Response: string;
    begin
    Response := 'save response webhook instagram ok';
    Res.Send(Response);

    Response := Req.Body;
    if Assigned(FOnResponseInstagram) then
    FOnResponseInstagram(Self, Response);
    end
    );

    THorse
    .Post('/responsemessenger',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
    Response: string;
    begin
    Response := 'save response webhook messenger ok';
    Res.Send(Response);

    Response := Req.Body;
    if Assigned(FOnResponseMessenger) then
    FOnResponseMessenger(Self, Response);
    end
    );

    if Port = 0 then
    Port := 8020;

    THorse.MaxConnections := 500;
    THorse.Port := Port;
    THorse.Listen; *)
end;

procedure TTypebotAPI.StopServer;
begin
  // THorse.StopListen;
end;

function TTypebotAPI.ContinueChat(sessionId, TextMessage: string; var response: string): string;
var
  JSON: string;
  //ResultTypebotStartChat: uTypebotResponseStartChat.TResultTypeBotStartChatClass;
  ResultTypeBotContinueChat: uTypeBotResponseContinueChat.TResultResponseContinueChatClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try

    JSON := '{ ' + '  "message": "' + TextMessage + '" ' + '}';

    UTF8Texto := UTF8Encode(JSON);

    try
      Response := TRequest.New.BaseURL(UrlTypebot + '/api/v1/sessions/' + sessionId + '/continueChat')
      // 'http://172.23.148.194:3002/api/v1/sessions/' + wlo_sessionId + '/continueChat';
        .ContentType('application/json')
      // .TokenBearer(TokenApiOficial)
        .AddBody(UTF8Texto).Post.Content;

    except
      on E: Exception do
      begin
        if Assigned(FOnRetSendMessage) then
          FOnRetSendMessage(Self, Response + 'Error: ' + E.Message);

        Result := 'Failed';
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

    except
      on E: Exception do
    end;

    try
      // ResultTypeBotStartChat := uTypeBotResponseStartChat.TResultTypeBotStartChatClass.FromJsonString(response);
      // Result := ResultTypeBotStartChat.sessionId;
      ResultTypeBotContinueChat := uTypeBotResponseContinueChat.TResultResponseContinueChatClass.FromJsonString(response);

      if Assigned(ResultTypeBotContinueChat.clientSideActions) then
        Result := ResultTypeBotContinueChat.clientSideActions[0].setVariable.scriptToExecute.content else
        Result := '';

    except
      on E: Exception do
      begin
        Result := 'Failed';
        Exit;
      end;
    end;

  finally
  end;
end;

function TTypebotAPI.GetContentTypeFromDataUri(const ADataUri: string): string;
begin
  // data:audio/mpeg;
  if pos('data:', ADataUri) > 0 then
    Result := Copy(ADataUri, 5, pos(';', ADataUri) - 1)
  else
    Result := 'text/plain';
end;

function TTypebotAPI.GetContentTypeFromExtension(const AContentType
  : string): string;
var
  ContentTypeList: TStringList;
begin
  ContentTypeList := TStringList.Create;
  try
    // Mapeamento de extensões para tipos de conteúdo
    ContentTypeList.Values['.html'] := 'text/html';
    ContentTypeList.Values['.htm'] := 'text/html';
    ContentTypeList.Values['.txt'] := 'text/plain';
    ContentTypeList.Values['.log'] := 'text/plain';
    ContentTypeList.Values['.csv'] := 'text/csv';
    ContentTypeList.Values['.jpg'] := 'image/jpeg';
    ContentTypeList.Values['.jpeg'] := 'image/jpeg';
    ContentTypeList.Values['.png'] := 'image/png';
    ContentTypeList.Values['.gif'] := 'image/gif';
    ContentTypeList.Values['.bmp'] := 'image/bmp';
    ContentTypeList.Values['.ico'] := 'image/x-icon';
    ContentTypeList.Values['.svg'] := 'image/svg+xml';
    ContentTypeList.Values['.pdf'] := 'application/pdf';
    ContentTypeList.Values['.doc'] := 'application/msword';
    ContentTypeList.Values['.docx'] :=
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    ContentTypeList.Values['.xls'] := 'application/vnd.ms-excel';
    ContentTypeList.Values['.xlsx'] :=
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    ContentTypeList.Values['.ppt'] := 'application/vnd.ms-powerpoint';
    ContentTypeList.Values['.pptx'] :=
      'application/vnd.openxmlformats-officedocument.presentationml.presentation';
    ContentTypeList.Values['.zip'] := 'application/zip';
    ContentTypeList.Values['.rar'] := 'application/x-rar-compressed';
    ContentTypeList.Values['.tar'] := 'application/x-tar';
    ContentTypeList.Values['.7z'] := 'application/x-7z-compressed';
    ContentTypeList.Values['.mp3'] := 'audio/mpeg';
    ContentTypeList.Values['.wav'] := 'audio/wav';
    ContentTypeList.Values['.mp4'] := 'video/mp4';
    ContentTypeList.Values['.avi'] := 'video/x-msvideo';
    ContentTypeList.Values['.mkv'] := 'video/x-matroska';
    ContentTypeList.Values['.xml'] := 'text/xml';
    ContentTypeList.Values['.json'] := 'application/json';
    ContentTypeList.Values['.ogg'] := 'audio/ogg';
    ContentTypeList.Values['.webm'] := 'video/webm';
    ContentTypeList.Values['.flv'] := 'video/x-flv';
    ContentTypeList.Values['.wmv'] := 'video/x-ms-wmv';
    ContentTypeList.Values['.aac'] := 'audio/aac';
    ContentTypeList.Values['.flac'] := 'audio/flac';
    ContentTypeList.Values['.css'] := 'text/css';
    ContentTypeList.Values['.js'] := 'application/javascript';
    ContentTypeList.Values['.ttf'] := 'font/ttf';
    ContentTypeList.Values['.otf'] := 'font/otf';
    ContentTypeList.Values['.woff'] := 'font/woff';
    ContentTypeList.Values['.woff2'] := 'font/woff2';
    // Adicione mais extensões e tipos de conteúdo conforme necessário

    Result := ContentTypeList.Values[AContentType];
  finally
    ContentTypeList.Free;
  end;
end;

function TTypebotAPI.GetExtensionTypeFromContentType(const AFileExtension
  : string): string;
var
  ContentTypeList: TStringList;
begin
  ContentTypeList := TStringList.Create;
  try
    ContentTypeList.Values['text/html'] := '.html';
    ContentTypeList.Values['text/plain'] := '.txt';
    ContentTypeList.Values['text/csv'] := '.csv';
    ContentTypeList.Values['image/jpeg'] := '.jpg';
    ContentTypeList.Values['image/png'] := '.png';
    ContentTypeList.Values['image/gif'] := '.gif';
    ContentTypeList.Values['image/bmp'] := '.bmp';
    ContentTypeList.Values['image/x-icon'] := '.ico';
    ContentTypeList.Values['image/svg+xml'] := '.svg';
    ContentTypeList.Values['application/pdf'] := '.pdf';
    ContentTypeList.Values['application/msword'] := '.doc';
    ContentTypeList.Values
      ['application/vnd.openxmlformats-officedocument.wordprocessingml.document']
      := '.docx';
    ContentTypeList.Values['application/vnd.ms-excel'] := '.xls';
    ContentTypeList.Values
      ['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet']
      := '.xlsx';
    ContentTypeList.Values['application/vnd.ms-powerpoint'] := '.ppt';
    ContentTypeList.Values
      ['application/vnd.openxmlformats-officedocument.presentationml.presentation']
      := '.pptx';
    ContentTypeList.Values['application/zip'] := '.zip';
    ContentTypeList.Values['application/x-rar-compressed'] := '.rar';
    ContentTypeList.Values['application/x-tar'] := '.tar';
    ContentTypeList.Values['application/x-7z-compressed'] := '.7z';
    ContentTypeList.Values['audio/mpeg'] := '.mp3';
    ContentTypeList.Values['audio/wav'] := '.wav';
    ContentTypeList.Values['audio/ogg; codecs=opus'] := '.ogg';
    ContentTypeList.Values['video/mp4'] := '.mp4';
    ContentTypeList.Values['video/x-msvideo'] := '.avi';
    ContentTypeList.Values['video/x-matroska'] := '.mkv';
    ContentTypeList.Values['text/xml'] := '.xml';
    ContentTypeList.Values['application/json'] := '.json';
    ContentTypeList.Values['audio/ogg'] := '.ogg';
    ContentTypeList.Values['video/webm'] := '.webm';
    ContentTypeList.Values['video/x-flv'] := '.flv';
    ContentTypeList.Values['video/x-ms-wmv'] := '.wmv';
    ContentTypeList.Values['audio/aac'] := '.aac';
    ContentTypeList.Values['audio/flac'] := '.flac';
    ContentTypeList.Values['text/css'] := '.css';
    ContentTypeList.Values['application/javascript'] := '.js';
    ContentTypeList.Values['font/ttf'] := '.ttf';
    ContentTypeList.Values['font/otf'] := '.otf';
    ContentTypeList.Values['font/woff'] := '.woff';
    ContentTypeList.Values['font/woff2'] := '.woff2';
    // Adicione mais tipos de conteúdo e extensões conforme necessário

    Result := ContentTypeList.Values[AFileExtension];
  finally
    ContentTypeList.Free;
  end;
end;

function TTypebotAPI.GetTypeFileFromContentType(const AContentType
  : string): string;
begin
  if AnsiLowerCase(Copy(AContentType, 1, pos('/', AContentType) - 1)) = 'image'
  then
    Result := 'image'
  else if AnsiLowerCase(Copy(AContentType, 1, pos('/', AContentType) - 1)) = 'audio'
  then
    Result := 'audio'
  else if AnsiLowerCase(Copy(AContentType, 1, pos('/', AContentType) - 1)) = 'video'
  then
    Result := 'video'
  else if AnsiLowerCase(Copy(AContentType, 1, pos('/', AContentType) - 1)) = 'text'
  then
    Result := 'document'
  else
    Result := 'document';
end;

end.
