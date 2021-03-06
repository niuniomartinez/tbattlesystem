{/***************************************************************************
                          uInventoryType.pas  -  description
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

unit uInventoryType;

interface

type

  TInventoryType = (Undefined = $00, Weapon = $01, Armor = $02, Shield = $04, ACC = $08, Potion = $10);

  TDamageTypes = (Slash = 0, Pierce, Blundgeon, Missile);

  TInventoryItem = class(TObject)
    protected
      fName: string;
      fWeight: Integer;
      fEquippable, fUseable, fBreakable: Boolean;
      fInventoryType: TInventoryType;
    public
      constructor Create(name: string; weight: Integer; equipable,useable,breakable: Boolean);
      function isUseless: Boolean;
      property isEquippable: Boolean read fEquippable;
      property isUseable: Boolean read fUseable;
      property isBreakable: Boolean read fBreakable;
      property InventoryType: TInventoryType read fInventoryType;
      property Weight: Integer read fWeight;
      property Name: String read fName;
  end;

implementation

constructor TInventoryItem.Create(name: string; weight: Integer; equipable: Boolean; useable: Boolean; breakable: Boolean);
begin
  fName:=name;
  fWeight:=weight;
  fEquippable:=equipable;
  fUseable:=useable;
  fbreakable:=breakable;
end;

function TInventoryItem.isUseless: Boolean;
begin
  Result:=((not fEquippable) and (not fUseable));
end;


end.
