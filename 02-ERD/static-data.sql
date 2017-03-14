--INSERT SCRIPT


-- INSERT INTO `Permission`
INSERT INTO `Inventory`.`Permission` (`Role`, `PermissionLevel`) VALUES ('User', '1');
INSERT INTO `Inventory`.`Permission` (`Role`, `PermissionLevel`) VALUES ('Management', '2');
INSERT INTO `Inventory`.`Permission` (`Role`, `PermissionLevel`) VALUES ('Administrator', '3');

-- INSERT INTO `Users`
INSERT INTO `Inventory`.`Users` (`FirstName`, `LastName`, `NickName`, `PermissionID`, `isDisable`, `UserName`, `Password`) VALUES ('Pornjed', 'Sakgitjarung', 'A', 3, 0, 'pornjeds', MD5('xvoo^db318'));
