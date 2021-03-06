{/***************************************************************************
                          uArmour.pas  -  description
                             -------------------
    begin                : Wed Jan 28 2014
    copyright            : (C) 2014 by Enrique Fuentes
    email                : deejaykike@gmail.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
 }
unit uArmour;

interface

uses uInventoryType;

type

  TShield = class;

  TArmorType = (None = 0, Leather, StLeather, Brigandine, ChainMail, Banded, PlateMail, FieldPlate, FullPlate);

  TArmour = class(TInventoryItem)
    private
      fbaseAC: Integer;
      fACMod: array [0..3] of Integer;
      fhasShield: Boolean;
      fShield: TShield;
      fArmorType: TArmorType;
      procedure equipShield;
      procedure removeShield;
    public
      constructor Create; overload;
      constructor Create(AC, Slashing, Piercing, Bludgeoning, Missile: Integer; name: string; weight: Integer; ArmorType: TArmorType); overload;
      constructor Create(Model: TArmour); overload;
      function getAC(DamegeType: TDamageTypes): Integer; overload;
      function getAC: Integer; overload;
      function getType: TInventoryType;
      property ArmorType: TArmorType read fArmorType;
  end;

  TShield = class(TInventoryItem)
    private
      fArmour: TArmour;
      fisAttached: Boolean;
    public
      constructor Create; overload;
      constructor Create(at: TArmour); overload;
      procedure Attach(at: TArmour);
      procedure Dettach;
      function getType: TInventoryType;
  end;

implementation

constructor TArmour.Create;
var
  i: Integer;
begin
  inherited Create('None',0,true,False,False);
  fArmorType:=None;
  fInventoryType:=TInventoryType.Armor;
  fbaseAC:=10;
  for I := 0 to 3 do
  begin
    fACMod[i]:=0;
  end;
  fhasShield:=False;
end;

constructor TArmour.Create(AC: Integer; Slashing: Integer; Piercing: Integer; Bludgeoning: Integer; Missile: Integer; name: string; weight: Integer; ArmorType: TArmorType);
begin
  inherited Create(name,weight,True,False,False);
  fInventoryType:=TInventoryType.Armor;
  fArmorType:=ArmorType;
  fbaseAC:=AC;
  fACMod[0]:=Slashing;
  fACMod[1]:=Piercing;
  fACMod[2]:=Bludgeoning;
  fACMod[3]:=Missile;
  fhasShield:=False;
end;

constructor TArmour.Create(Model: TArmour);
begin
  inherited Create(model.Name,Model.Weight,True,false,False);
  fInventoryType:=TInventoryType.Armor;
  fbaseAC:=Model.fbaseAC;
  fArmorType:=Model.fArmorType;
  fACMod[0]:=Model.fACMod[0];
  fACMod[1]:=Model.fACMod[1];
  fACMod[2]:=Model.fACMod[2];
  fACMod[3]:=Model.fACMod[3];
  fhasShield:=False;
end;

function TArmour.getAC(DamegeType: TDamageTypes): Integer;
begin
  Result:=fbaseAC - fACMod[Integer(DamegeType)] - Integer(fhasShield);
end;

function TArmour.getAC: Integer;
begin
  Result:=fbaseAC - Integer(fhasShield);
end;

function TArmour.getType: TInventoryType;
begin
  Result:=fInventoryType;
end;

procedure TArmour.equipShield;
begin
  fhasShield:=True;
end;

procedure TArmour.removeShield;
begin
  fhasShield:=False;
end;

constructor TShield.Create;
begin
  inherited Create('Shield', 50, True, false, False);
  fisAttached:=False;
  fInventoryType:=TInventoryType.Shield;
  fArmour:=nil;
end;

constructor TShield.Create(at: TArmour);
begin
  inherited Create('Shield', 50, True, false, False);
  fArmour:=at;
  fArmour.equipShield;
  fisAttached:=True;
  fInventoryType:=TInventoryType.Shield;
end;

procedure TShield.Attach(at: TArmour);
begin
  if fisAttached then Dettach;
  fArmour:=at;
  fArmour.equipShield;
  fisAttached:=True;
  fInventoryType:=TInventoryType.Shield;
end;

procedure TShield.Dettach;
begin
  fisAttached:=False;
  fArmour.removeShield;
  fArmour:=nil;
end;

function TShield.getType: TInventoryType;
begin
  Result:=fInventoryType;
end;


end.
