-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Creato il: Mar 11, 2019 alle 08:56
-- Versione del server: 10.1.19-MariaDB
-- Versione PHP: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `libridb`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `carrelli`
--

CREATE TABLE `carrelli` (
  `id` int(11) NOT NULL,
  `utente` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `carrelli`
--

INSERT INTO `carrelli` (`id`, `utente`) VALUES
(3, '3274733737'),
(5, '3332103202'),
(1, '3388410063'),
(2, '3466788612'),
(4, '3923922600');

-- --------------------------------------------------------

--
-- Struttura della tabella `categorie`
--

CREATE TABLE `categorie` (
  `tipo` varchar(25) NOT NULL,
  `sconto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `categorie`
--

INSERT INTO `categorie` (`tipo`, `sconto`) VALUES
('Da non perdere', 20),
('I piu venduti', 0),
('Offerte speciali', 25),
('Remainders', 50),
('Ultimi arrivi', 0);

-- --------------------------------------------------------

--
-- Struttura della tabella `categorielibri`
--

CREATE TABLE `categorielibri` (
  `libro` int(11) NOT NULL,
  `categoria` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `categorielibri`
--

INSERT INTO `categorielibri` (`libro`, `categoria`) VALUES
(1, 'I più venduti'),
(2, 'Offerte speciali'),
(3, 'Da non perdere'),
(4, 'Ultimi arrivi');

-- --------------------------------------------------------

--
-- Struttura della tabella `libri`
--

CREATE TABLE `libri` (
  `id` int(11) NOT NULL,
  `titolo` varchar(25) NOT NULL,
  `prezzo` float NOT NULL,
  `nPagine` int(11) NOT NULL,
  `rilegato` varchar(2) NOT NULL,
  `annoPubblicazione` int(11) NOT NULL,
  `collana` varchar(25) NOT NULL,
  `dataArch` date NOT NULL,
  `reparto` int(11) NOT NULL,
  `editore` varchar(25) NOT NULL,
  `autore` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `libri`
--

INSERT INTO `libri` (`id`, `titolo`, `prezzo`, `nPagine`, `rilegato`, `annoPubblicazione`, `collana`, `dataArch`, `reparto`, `editore`, `autore`) VALUES
(1, 'Il Buio Oltre La Siepe', 5, 317, '1', 1960, 'Grandi classici', '2018-12-22', 10, 'Feltrinelli', 'Harper Lee'),
(2, 'Racconto di due citta', 11, 317, '1', 1859, 'Narratori moderni', '2018-12-10', 10, 'Feltrinelli', 'Charles Dickens'),
(3, 'Il signore degli anelli', 42, 317, '1', 1954, 'Narratori moderni', '2019-01-14', 7, 'Feltrinelli', 'John Ronald Reuel Tolkien'),
(4, 'Naruto', 13, 317, '1', 1984, 'Narratori moderni', '2018-11-09', 9, 'Feltrinelli', 'Akira Toriyama');

-- --------------------------------------------------------

--
-- Struttura della tabella `libricarrello`
--

CREATE TABLE `libricarrello` (
  `libro` int(11) NOT NULL,
  `carrello` int(11) NOT NULL,
  `nCopie` int(11) NOT NULL,
  `disponibilita` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `libricarrello`
--

INSERT INTO `libricarrello` (`libro`, `carrello`, `nCopie`, `disponibilita`) VALUES
(1, 1, 1, 1),
(2, 1, 1, 1),
(3, 2, 1, 1),
(4, 4, 2, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `reparti`
--

CREATE TABLE `reparti` (
  `id` int(11) NOT NULL,
  `tipo` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `reparti`
--

INSERT INTO `reparti` (`id`, `tipo`) VALUES
(1, 'Architettura'),
(2, 'Arte'),
(3, 'Classici greci e latini'),
(4, 'Cucina e casa'),
(5, 'Diritto'),
(6, 'Economia'),
(7, 'Fantasy'),
(8, 'Filosofia'),
(9, 'Fumetti'),
(10, 'Romanzo');

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `telefono` varchar(10) NOT NULL,
  `nome` varchar(25) NOT NULL,
  `cognome` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `username` varchar(20) NOT NULL,
  `indirizzo` varchar(30) NOT NULL,
  `cap` varchar(5) NOT NULL,
  `citta` varchar(30) NOT NULL,
  `nazione` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`telefono`, `nome`, `cognome`, `email`, `username`, `indirizzo`, `cap`, `citta`, `nazione`) VALUES
('3274733737', 'Enrico', 'Gobbi', 'enrico.gobbi@gmail.com', 'gobbi', 'Via Montaletto', '48015', 'Cervia', 'Italia'),
('3332103202', 'Alice', 'Tosi', 'alice.tosi@gmail.com', 'tosi', 'Via Anna Frank', '48015', 'Cervia', 'Italia'),
('3388410063', 'Francesco', 'Rossi', 'checcorossi00@gmail.com', 'rossi', 'via rizzoli', '48015', 'Cervia', 'Italia'),
('3466788612', 'Alex', 'Carlone', 'alex.carlone@gmail.com', 'rossi', 'via orte', '47521', 'Cesena', 'Italia'),
('3923922600', 'Alessandro', 'Giunchi', 'giunchialessandro00@gmail', 'giunchi', 'Via Bigatta', '48015', 'Cervia', 'Italia');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `carrelli`
--
ALTER TABLE `carrelli`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utente` (`utente`);

--
-- Indici per le tabelle `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`tipo`);

--
-- Indici per le tabelle `categorielibri`
--
ALTER TABLE `categorielibri`
  ADD PRIMARY KEY (`libro`,`categoria`),
  ADD KEY `categoria` (`categoria`);

--
-- Indici per le tabelle `libri`
--
ALTER TABLE `libri`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reparto` (`reparto`);

--
-- Indici per le tabelle `libricarrello`
--
ALTER TABLE `libricarrello`
  ADD PRIMARY KEY (`libro`,`carrello`),
  ADD KEY `carrello` (`carrello`);

--
-- Indici per le tabelle `reparti`
--
ALTER TABLE `reparti`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`telefono`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `carrelli`
--
ALTER TABLE `carrelli`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT per la tabella `libri`
--
ALTER TABLE `libri`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `carrelli`
--
ALTER TABLE `carrelli`
  ADD CONSTRAINT `carrelli_ibfk_1` FOREIGN KEY (`utente`) REFERENCES `utenti` (`telefono`);

--
-- Limiti per la tabella `categorielibri`
--
ALTER TABLE `categorielibri`
  ADD CONSTRAINT `categorielibri_ibfk_2` FOREIGN KEY (`categoria`) REFERENCES `categorie` (`tipo`),
  ADD CONSTRAINT `categorielibri_ibfk_3` FOREIGN KEY (`libro`) REFERENCES `libri` (`id`);

--
-- Limiti per la tabella `libri`
--
ALTER TABLE `libri`
  ADD CONSTRAINT `libri_ibfk_1` FOREIGN KEY (`reparto`) REFERENCES `reparti` (`id`);

--
-- Limiti per la tabella `libricarrello`
--
ALTER TABLE `libricarrello`
  ADD CONSTRAINT `libricarrello_ibfk_2` FOREIGN KEY (`carrello`) REFERENCES `carrelli` (`id`),
  ADD CONSTRAINT `libricarrello_ibfk_3` FOREIGN KEY (`libro`) REFERENCES `libri` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
