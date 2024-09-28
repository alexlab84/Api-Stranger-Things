CREATE TABLE `stranger_things`.`capitulos` (
  `num capitulo` INT NOT NULL,
  `titulo capitulo` TEXT NOT NULL,
  `fecha estreno` DATE NOT NULL,
  `valoracion` FLOAT NULL);

  ALTER TABLE `stranger_things`.`capitulos` 
ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT AFTER `num capitulo`,
ADD PRIMARY KEY (`id`);

ALTER TABLE `stranger_things`.`capitulos` 
CHANGE COLUMN `id` `id` INT NOT NULL AUTO_INCREMENT FIRST;

INSERT INTO `stranger_things`.`capitulos` (`id`, `num capitulo`, `titulo capitulo`, `fecha estreno`, `valoracion`) VALUES ('1', '1', 'La desaparición de Will Byers', '2016-07-15', '5.0');
INSERT INTO `stranger_things`.`capitulos` (`id`, `num capitulo`, `titulo capitulo`, `fecha estreno`, `valoracion`) VALUES ('2', '2', 'La loca de la calle Maple', '2016-07-22', '4.0');
INSERT INTO `stranger_things`.`capitulos` (`id`, `num capitulo`, `titulo capitulo`, `fecha estreno`, `valoracion`) VALUES ('3', '3', 'El renacuajo', '2017-10-27', '4.0');
INSERT INTO `stranger_things`.`capitulos` (`id`, `num capitulo`, `titulo capitulo`, `fecha estreno`, `valoracion`) VALUES ('4', '4', 'Will el Sabio', '2017-11-03', '5.0');
INSERT INTO `stranger_things`.`capitulos` (`id`, `num capitulo`, `titulo capitulo`, `fecha estreno`, `valoracion`) VALUES ('5', '5', 'El ejercito del azotamentes', '2019-07-04', '5.0');
INSERT INTO `stranger_things`.`capitulos` (`id`, `num capitulo`, `titulo capitulo`, `fecha estreno`, `valoracion`) VALUES ('6', '6', 'E pluribus unum', '2019-07-11', '4.0');
INSERT INTO `stranger_things`.`capitulos` (`id`, `num capitulo`, `titulo capitulo`, `fecha estreno`, `valoracion`) VALUES ('7', '7', 'Papa', '2022-07-01', '4.0');
INSERT INTO `stranger_things`.`capitulos` (`id`, `num capitulo`, `titulo capitulo`, `fecha estreno`, `valoracion`) VALUES ('8', '8', 'El huesped', '2022-07-08', '5.0');

ALTER TABLE `stranger_things`.`capitulos` 
CHANGE COLUMN `num capitulo` `numero` INT NOT NULL ,
CHANGE COLUMN `titulo capitulo` `titulo` TEXT NOT NULL ;

ALTER TABLE `stranger_things`.`capitulos` 
CHANGE COLUMN `fecha estreno` `fecha_estreno` DATE NOT NULL ;

CREATE TABLE `stranger_things`.`actores` (
  `idactores` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `personaje` VARCHAR(45) NOT NULL,
  `edad` INT NOT NULL,
  `ciudad_natal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idactores`));

  INSERT INTO `stranger_things`.`actores` (`idactores`, `nombre`, `personaje`, `edad`, `ciudad_natal`) VALUES ('1', 'Millie Bobby Brown', 'Eleven', '20', 'Marbella');
INSERT INTO `stranger_things`.`actores` (`idactores`, `nombre`, `personaje`, `edad`, `ciudad_natal`) VALUES ('2', 'Finn Wolfhard', 'Mike Wheeler', '21', 'Vancouver');
INSERT INTO `stranger_things`.`actores` (`idactores`, `nombre`, `personaje`, `edad`, `ciudad_natal`) VALUES ('3', 'Noah Schnapp', 'Will Byers', '19', 'Nueva York');
INSERT INTO `stranger_things`.`actores` (`idactores`, `nombre`, `personaje`, `edad`, `ciudad_natal`) VALUES ('4', 'Caleb Mclaughlin', 'Lucas Sinclair', '22', 'Nueva York');
INSERT INTO `stranger_things`.`actores` (`idactores`, `nombre`, `personaje`, `edad`, `ciudad_natal`) VALUES ('5', 'Gaten Matarazzo', 'Dustin Herdenson', '22', 'New London');
INSERT INTO `stranger_things`.`actores` (`idactores`, `nombre`, `personaje`, `edad`, `ciudad_natal`) VALUES ('6', 'Winona Ryder', 'Joyce Byers', '52', 'Minesota');
INSERT INTO `stranger_things`.`actores` (`idactores`, `nombre`, `personaje`, `edad`, `ciudad_natal`) VALUES ('7', 'David Harbour', 'Jim Hopper', '49', 'Nueva York');
INSERT INTO `stranger_things`.`actores` (`idactores`, `nombre`, `personaje`, `edad`, `ciudad_natal`) VALUES ('8', 'Joe Keery', 'Steve Harrington', '32', 'Massachusetts');

-- CREATE TABLE `stranger_things`.`temporadas` (
--   `idtemporadas` INT NOT NULL AUTO_INCREMENT,
--   `numero` INT NOT NULL,
--   `año_estreno` INT NOT NULL,
--   `episodios_totales` INT NOT NULL,
--   `descripción` TEXT NULL,
--   PRIMARY KEY (`idtemporadas`));


CREATE TABLE IF NOT EXISTS `stranger_things`.`capitulos_has_actores` (
  `capitulos_id` INT(11) NOT NULL,
  `actores_idactores` INT(11) NOT NULL,
  PRIMARY KEY (`capitulos_id`, `actores_idactores`),
  INDEX `fk_capitulos_has_actores_actores1_idx` (`actores_idactores` ASC) VISIBLE,
  INDEX `fk_capitulos_has_actores_capitulos_idx` (`capitulos_id` ASC) VISIBLE,
  CONSTRAINT `fk_capitulos_has_actores_capitulos`
    FOREIGN KEY (`capitulos_id`)
    REFERENCES `stranger_things`.`capitulos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_capitulos_has_actores_actores1`
    FOREIGN KEY (`actores_idactores`)
    REFERENCES `stranger_things`.`actores` (`idactores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


CREATE TABLE `stranger_things`.`usuarias` (
  `id` INT NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `password_UNIQUE` (`password` ASC) VISIBLE);

ALTER TABLE `stranger_things`.`usuarias` 
CHANGE COLUMN `password` `password` CHAR(60) NOT NULL ;

ALTER TABLE `stranger_things`.`usuarias` 
CHANGE COLUMN `id` `id` INT NOT NULL AUTO_INCREMENT ;
