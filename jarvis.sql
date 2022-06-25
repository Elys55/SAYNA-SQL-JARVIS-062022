-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 23, 2022 at 08:00 AM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jarvis`
--

-- --------------------------------------------------------

--
-- Table structure for table `appareil`
--

DROP TABLE IF EXISTS `appareil`;
CREATE TABLE IF NOT EXISTS `appareil` (
  `id_appareil` int(11) NOT NULL,
  `Nom_appareil` varchar(45) DEFAULT NULL,
  `Type_appareil` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_appareil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `contenir`
--

DROP TABLE IF EXISTS `contenir`;
CREATE TABLE IF NOT EXISTS `contenir` (
  `Domicile_id_domicile` int(11) NOT NULL,
  `Utilisateur_id_U` int(11) NOT NULL,
  PRIMARY KEY (`Domicile_id_domicile`,`Utilisateur_id_U`),
  KEY `fk_Domicile_has_Utilisateur_Utilisateur1_idx` (`Utilisateur_id_U`),
  KEY `fk_Domicile_has_Utilisateur_Domicile1_idx` (`Domicile_id_domicile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `co_proprietaire`
--

DROP TABLE IF EXISTS `co_proprietaire`;
CREATE TABLE IF NOT EXISTS `co_proprietaire` (
  `Utilisateur_id_U` int(11) NOT NULL,
  `id_Co_proprietaire` int(11) NOT NULL,
  `lien_parente` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Utilisateur_id_U`,`id_Co_proprietaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `domicile`
--

DROP TABLE IF EXISTS `domicile`;
CREATE TABLE IF NOT EXISTS `domicile` (
  `id_domicile` int(11) NOT NULL,
  `Annee_construction` varchar(45) DEFAULT NULL,
  `Superficie` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_domicile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `invite`
--

DROP TABLE IF EXISTS `invite`;
CREATE TABLE IF NOT EXISTS `invite` (
  `Proprietaire_Utilisateur_id_U` int(11) NOT NULL,
  `Proprietaire_id_proprietaire` varchar(45) NOT NULL,
  `Utilisateur_id_U` int(11) NOT NULL,
  PRIMARY KEY (`Proprietaire_Utilisateur_id_U`,`Proprietaire_id_proprietaire`,`Utilisateur_id_U`),
  KEY `fk_Proprietaire_has_Utilisateur_Utilisateur1_idx` (`Utilisateur_id_U`),
  KEY `fk_Proprietaire_has_Utilisateur_Proprietaire1_idx` (`Proprietaire_Utilisateur_id_U`,`Proprietaire_id_proprietaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `membres`
--

DROP TABLE IF EXISTS `membres`;
CREATE TABLE IF NOT EXISTS `membres` (
  `Utilisateur_id_U` int(11) NOT NULL,
  `id_membres` int(11) NOT NULL,
  `lien_parente` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Utilisateur_id_U`,`id_membres`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pieces`
--

DROP TABLE IF EXISTS `pieces`;
CREATE TABLE IF NOT EXISTS `pieces` (
  `id_piece` int(11) NOT NULL,
  `Nom_piece` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_piece`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `proprietaire`
--

DROP TABLE IF EXISTS `proprietaire`;
CREATE TABLE IF NOT EXISTS `proprietaire` (
  `Utilisateur_id_U` int(11) NOT NULL,
  `id_proprietaire` varchar(45) NOT NULL,
  `lien_parente` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Utilisateur_id_U`,`id_proprietaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `se trouve`
--

DROP TABLE IF EXISTS `se trouve`;
CREATE TABLE IF NOT EXISTS `se trouve` (
  `Appareil_id_appareil` int(11) NOT NULL,
  `Pieces_id_piece` int(11) NOT NULL,
  PRIMARY KEY (`Appareil_id_appareil`,`Pieces_id_piece`),
  KEY `fk_Appareil_has_Pieces_Pieces1_idx` (`Pieces_id_piece`),
  KEY `fk_Appareil_has_Pieces_Appareil1_idx` (`Appareil_id_appareil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id_U` int(11) NOT NULL,
  `nom_U` varchar(45) DEFAULT NULL,
  `date_naissance_U` date DEFAULT NULL,
  `sexe_U` varchar(1) DEFAULT NULL,
  `mot_de_passe_U` varchar(10) DEFAULT NULL,
  `email_U` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_U`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contenir`
--
ALTER TABLE `contenir`
  ADD CONSTRAINT `fk_Domicile_has_Utilisateur_Domicile1` FOREIGN KEY (`Domicile_id_domicile`) REFERENCES `domicile` (`id_domicile`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Domicile_has_Utilisateur_Utilisateur1` FOREIGN KEY (`Utilisateur_id_U`) REFERENCES `utilisateur` (`id_U`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `co_proprietaire`
--
ALTER TABLE `co_proprietaire`
  ADD CONSTRAINT `fk_Co-proprietaire_Utilisateur1` FOREIGN KEY (`Utilisateur_id_U`) REFERENCES `utilisateur` (`id_U`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `invite`
--
ALTER TABLE `invite`
  ADD CONSTRAINT `fk_Proprietaire_has_Utilisateur_Proprietaire1` FOREIGN KEY (`Proprietaire_Utilisateur_id_U`,`Proprietaire_id_proprietaire`) REFERENCES `proprietaire` (`Utilisateur_id_U`, `id_proprietaire`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Proprietaire_has_Utilisateur_Utilisateur1` FOREIGN KEY (`Utilisateur_id_U`) REFERENCES `utilisateur` (`id_U`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `membres`
--
ALTER TABLE `membres`
  ADD CONSTRAINT `fk_Membres_Utilisateur` FOREIGN KEY (`Utilisateur_id_U`) REFERENCES `utilisateur` (`id_U`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `proprietaire`
--
ALTER TABLE `proprietaire`
  ADD CONSTRAINT `fk_Proprietaire_Utilisateur1` FOREIGN KEY (`Utilisateur_id_U`) REFERENCES `utilisateur` (`id_U`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `se trouve`
--
ALTER TABLE `se trouve`
  ADD CONSTRAINT `fk_Appareil_has_Pieces_Appareil1` FOREIGN KEY (`Appareil_id_appareil`) REFERENCES `appareil` (`id_appareil`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Appareil_has_Pieces_Pieces1` FOREIGN KEY (`Pieces_id_piece`) REFERENCES `pieces` (`id_piece`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
