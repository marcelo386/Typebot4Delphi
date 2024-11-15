unit uTypebotResponseStartChat;

// *************************************************
// Generated By: JsonToDelphiClass - 0.65
// Project link: https://github.com/PKGeorgiev/Delphi-JsonToDelphiClass
// Generated On: 2024-11-11 22:47:26
// *************************************************
// Created By  : Petar Georgiev - 2014
// WebSite     : http://pgeorgiev.com
// *************************************************

interface

uses Generics.Collections, Rest.Json;

type

  TOptionsClass = class
  private
    FVariableId: String;
  public
    property variableId: String read FVariableId write FVariableId;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TOptionsClass;
  end;

  TInputClass = class
  private
    FId: String;
    FOptions: TOptionsClass;
    FOutgoingEdgeId: String;
    FType: String;
  public
    property id: String read FId write FId;
    property options: TOptionsClass read FOptions write FOptions;
    property outgoingEdgeId: String read FOutgoingEdgeId write FOutgoingEdgeId;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TInputClass;
  end;

  TChildrenClass = class
  private
    FText: String;
  public
    property text: String read FText write FText;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TChildrenClass;
  end;

  TRichTextClass = class
  private
    FChildren: TArray<TChildrenClass>;
    FType: String;
  public
    property children: TArray<TChildrenClass> read FChildren write FChildren;
    property &type: String read FType write FType;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRichTextClass;
  end;

  TContentClass = class
  private
    FRichText: TArray<TRichTextClass>;
    FType: String;
  public
    property richText: TArray<TRichTextClass> read FRichText write FRichText;
    property &type: String read FType write FType;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TContentClass;
  end;

  TMessagesClassTypebot = class
  private
    FContent: TContentClass;
    FId: String;
    FType: String;
  public
    property content: TContentClass read FContent write FContent;
    property id: String read FId write FId;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TMessagesClassTypebot;
  end;

  TGeneralClass = class
  private
    FIsBrandingEnabled: Boolean;
  public
    property isBrandingEnabled: Boolean read FIsBrandingEnabled
      write FIsBrandingEnabled;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TGeneralClass;
  end;

  TSettingsClass = class
  private
    FGeneral: TGeneralClass;
  public
    property general: TGeneralClass read FGeneral write FGeneral;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSettingsClass;
  end;

  TThemeClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TThemeClass;
  end;

  TTypebotClass = class
  private
    FId: String;
    FPublishedAt: String;
    FSettings: TSettingsClass;
    FTheme: TThemeClass;
  public
    property id: String read FId write FId;
    property publishedAt: String read FPublishedAt write FPublishedAt;
    property settings: TSettingsClass read FSettings write FSettings;
    property theme: TThemeClass read FTheme write FTheme;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TTypebotClass;
  end;

  TResultTypeBotStartChatClass = class
  private
    FInput: TInputClass;
    FMessages: TArray<TMessagesClassTypebot>;
    FResultId: String;
    FSessionId: String;
    FTypebot: TTypebotClass;
  public
    property input: TInputClass read FInput write FInput;
    property messages: TArray<TMessagesClassTypebot> read FMessages
      write FMessages;
    property resultId: String read FResultId write FResultId;
    property sessionId: String read FSessionId write FSessionId;
    property typebot: TTypebotClass read FTypebot write FTypebot;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string)
      : TResultTypeBotStartChatClass;
  end;

implementation

{ TOptionsClass }

function TOptionsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TOptionsClass.FromJsonString(AJsonString: string): TOptionsClass;
begin
  result := TJson.JsonToObject<TOptionsClass>(AJsonString)
end;

{ TInputClass }

constructor TInputClass.Create;
begin
  inherited;
  FOptions := TOptionsClass.Create();
end;

destructor TInputClass.Destroy;
begin
  FOptions.free;
  inherited;
end;

function TInputClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TInputClass.FromJsonString(AJsonString: string): TInputClass;
begin
  result := TJson.JsonToObject<TInputClass>(AJsonString)
end;

{ TChildrenClass }

function TChildrenClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TChildrenClass.FromJsonString(AJsonString: string)
  : TChildrenClass;
begin
  result := TJson.JsonToObject<TChildrenClass>(AJsonString)
end;

{ TRichTextClass }

destructor TRichTextClass.Destroy;
var
  LchildrenItem: TChildrenClass;
begin

  for LchildrenItem in FChildren do
    LchildrenItem.free;

  inherited;
end;

function TRichTextClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRichTextClass.FromJsonString(AJsonString: string)
  : TRichTextClass;
begin
  result := TJson.JsonToObject<TRichTextClass>(AJsonString)
end;

{ TContentClass }

destructor TContentClass.Destroy;
var
  LrichTextItem: TRichTextClass;
begin

  for LrichTextItem in FRichText do
    LrichTextItem.free;

  inherited;
end;

function TContentClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TContentClass.FromJsonString(AJsonString: string): TContentClass;
begin
  result := TJson.JsonToObject<TContentClass>(AJsonString)
end;

{ TMessagesClassTypebot }

constructor TMessagesClassTypebot.Create;
begin
  inherited;
  FContent := TContentClass.Create();
end;

destructor TMessagesClassTypebot.Destroy;
begin
  FContent.free;
  inherited;
end;

function TMessagesClassTypebot.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMessagesClassTypebot.FromJsonString(AJsonString: string)
  : TMessagesClassTypebot;
begin
  result := TJson.JsonToObject<TMessagesClassTypebot>(AJsonString)
end;

{ TGeneralClass }

function TGeneralClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TGeneralClass.FromJsonString(AJsonString: string): TGeneralClass;
begin
  result := TJson.JsonToObject<TGeneralClass>(AJsonString)
end;

{ TSettingsClass }

constructor TSettingsClass.Create;
begin
  inherited;
  FGeneral := TGeneralClass.Create();
end;

destructor TSettingsClass.Destroy;
begin
  FGeneral.free;
  inherited;
end;

function TSettingsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSettingsClass.FromJsonString(AJsonString: string)
  : TSettingsClass;
begin
  result := TJson.JsonToObject<TSettingsClass>(AJsonString)
end;

{ TThemeClass }

function TThemeClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TThemeClass.FromJsonString(AJsonString: string): TThemeClass;
begin
  result := TJson.JsonToObject<TThemeClass>(AJsonString)
end;

{ TTypebotClass }

constructor TTypebotClass.Create;
begin
  inherited;
  FTheme := TThemeClass.Create();
  FSettings := TSettingsClass.Create();
end;

destructor TTypebotClass.Destroy;
begin
  FTheme.free;
  FSettings.free;
  inherited;
end;

function TTypebotClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TTypebotClass.FromJsonString(AJsonString: string): TTypebotClass;
begin
  result := TJson.JsonToObject<TTypebotClass>(AJsonString)
end;

{ TResultTypeBotStartChatClass }

constructor TResultTypeBotStartChatClass.Create;
begin
  inherited;
  FTypebot := TTypebotClass.Create();
  FInput := TInputClass.Create();
end;

destructor TResultTypeBotStartChatClass.Destroy;
var
  LmessagesItem: TMessagesClassTypebot;
begin

  for LmessagesItem in FMessages do
    LmessagesItem.free;

  FTypebot.free;
  FInput.free;
  inherited;
end;

function TResultTypeBotStartChatClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TResultTypeBotStartChatClass.FromJsonString(AJsonString: string)
  : TResultTypeBotStartChatClass;
begin
  result := TJson.JsonToObject<TResultTypeBotStartChatClass>(AJsonString)
end;

end.
