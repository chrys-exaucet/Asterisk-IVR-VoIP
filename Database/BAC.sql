SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Etudiant`;
DROP TABLE IF EXISTS `Etablissement`;
DROP TABLE IF EXISTS `Adresse`;
DROP TABLE IF EXISTS `Jury`;
DROP TABLE IF EXISTS `Matiere`;
DROP TABLE IF EXISTS `Resultat`;
DROP TABLE IF EXISTS `Rattrapage`;
DROP TABLE IF EXISTS `Rattrapage `;
DROP TABLE IF EXISTS `Consultation`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `Etudiant` (
    `numTable` BIGINT NOT NULL,
    `nomEtu` VARCHAR NOT NULL,
    `prenomEtu` VARCHAR NOT NULL,
    `ageEtu` INTEGER NOT NULL,
    `genre` CHAR NOT NULL,
    `dateNaiss` DATE NOT NULL,
    `lieuNaiss` VARCHAR NOT NULL,
    `numTel` BIGINT NOT NULL,
    `adrMail` VARCHAR NOT NULL,
    `idAdr` BIGINT NOT NULL,
    PRIMARY KEY (`numTable`)
);

CREATE TABLE `Etablissement` (
    `idEtab` BIGINT NOT NULL,
    `nomEtab` VARCHAR NOT NULL,
    `numTelEtab` BIGINT NOT NULL,
    `idAdr` BIGINT NOT NULL,
    PRIMARY KEY (`idEtab`)
);

CREATE TABLE `Adresse` (
    `idAdr` BIGINT NOT NULL,
    `numRue` INTEGER NOT NULL,
    `nomCommune` VARCHAR NOT NULL,
    `nomDep` VARCHAR NOT NULL,
    PRIMARY KEY (`idAdr`)
);

CREATE TABLE `Jury` (
    `idJury` BIGINT NOT NULL,
    `nomJury` VARCHAR NOT NULL,
    PRIMARY KEY (`idJury`)
);

CREATE TABLE `Matiere` (
    `idMatiere` BIGINT NOT NULL,
    `nomMatiere` VARCHAR NOT NULL,
    `noteMatiere` INTEGER NOT NULL,
    `validationMatiere` BOOLEAN NOT NULL,
    `numTable` BIGINT NOT NULL,
    `coeffMat` INT NOT NULL,
    PRIMARY KEY (`idMatiere`)
);

CREATE TABLE `Resultat` (
    `admissionRes` VARCHAR NOT NULL,
    `moyRes` FLOAT NOT NULL,
    `mentionRes` VARCHAR NOT NULL,
    `numTable` BIGINT NOT NULL,
    `numTable` BIGINT NOT NULL,
    PRIMARY KEY (`numTable`)
);

CREATE TABLE `Rattrapage` (
);

CREATE TABLE `Rattrapage ` (
    `dateRattrapage` DATE NOT NULL,
    `idEtab` BIGINT NOT NULL
);

CREATE TABLE `Consultation` (
    `derniereConsultation` DATE NOT NULL,
    `nbreConsultation` INTEGER NOT NULL,
    `numTable` BIGINT NOT NULL,
    PRIMARY KEY (`numTable`)
);

ALTER TABLE `Etudiant` ADD FOREIGN KEY (`idAdr`) REFERENCES `Adresse`(`idAdr`);
ALTER TABLE `Etablissement` ADD FOREIGN KEY (`idAdr`) REFERENCES `Adresse`(`idAdr`);
ALTER TABLE `Matiere` ADD FOREIGN KEY (`numTable`) REFERENCES `Etudiant`(`numTable`);
ALTER TABLE `Resultat` ADD FOREIGN KEY (`numTable`) REFERENCES `Etudiant`(`numTable`);
ALTER TABLE `Rattrapage ` ADD FOREIGN KEY (`idEtab`) REFERENCES `Etablissement`(`idEtab`);
ALTER TABLE `Consultation` ADD FOREIGN KEY (`numTable`) REFERENCES `Etudiant`(`numTable`);