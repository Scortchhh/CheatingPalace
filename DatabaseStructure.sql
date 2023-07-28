-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Gegenereerd op: 03 jul 2023 om 19:14
-- Serverversie: 8.0.33-0ubuntu0.22.04.2
-- PHP-versie: 8.1.2-1ubuntu2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `CheatingPalace`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `extend_codes`
--

CREATE TABLE `extend_codes` (
  `id` int NOT NULL,
  `code` varchar(55) NOT NULL,
  `points` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `init_codes`
--

CREATE TABLE `init_codes` (
  `id` int NOT NULL,
  `code` varchar(255) NOT NULL,
  `subDuration` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `injected_scripts`
--

CREATE TABLE `injected_scripts` (
  `id` int NOT NULL,
  `date` varchar(255) NOT NULL,
  `hwid` varchar(255) NOT NULL,
  `accountName` varchar(255) NOT NULL,
  `scripts` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `load_file`
--

CREATE TABLE `load_file` (
  `id` int NOT NULL,
  `hwid` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `log_api`
--

CREATE TABLE `log_api` (
  `id` int NOT NULL,
  `status` varchar(256) NOT NULL,
  `message` varchar(256) NOT NULL,
  `date` datetime NOT NULL,
  `hwid` varchar(256) NOT NULL,
  `address` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `discordToken` varchar(256) NOT NULL,
  `loaderCode` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `log_dashboard`
--

CREATE TABLE `log_dashboard` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `type` varchar(256) NOT NULL,
  `date` datetime NOT NULL,
  `hwid` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `log_declined`
--

CREATE TABLE `log_declined` (
  `id` int NOT NULL,
  `status` varchar(256) NOT NULL,
  `message` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `date` datetime NOT NULL,
  `hwid` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `adress` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `log_hwid`
--

CREATE TABLE `log_hwid` (
  `id` int NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `message` varchar(256) NOT NULL,
  `date` datetime NOT NULL,
  `hwid` varchar(256) NOT NULL,
  `adress` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `log_injected`
--

CREATE TABLE `log_injected` (
  `id` int NOT NULL,
  `status` varchar(256) NOT NULL,
  `message` varchar(256) NOT NULL,
  `date` datetime NOT NULL,
  `hwid` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `adress` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `log_reset`
--

CREATE TABLE `log_reset` (
  `id` int NOT NULL,
  `status` varchar(256) NOT NULL,
  `message` varchar(256) NOT NULL,
  `date` datetime NOT NULL,
  `hwid` varchar(256) NOT NULL,
  `adress` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `log_success`
--

CREATE TABLE `log_success` (
  `id` int NOT NULL,
  `message` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `date` datetime NOT NULL,
  `code` varchar(256) NOT NULL,
  `hwid` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `discordToken` varchar(256) NOT NULL,
  `adress` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `patch_lol`
--

CREATE TABLE `patch_lol` (
  `id` int NOT NULL,
  `riotPatch` varchar(20) NOT NULL,
  `cheatPatch` varchar(20) NOT NULL,
  `loaderPatch` double NOT NULL,
  `globalPassword` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `payments`
--

CREATE TABLE `payments` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `invoiceID` varchar(256) NOT NULL,
  `status` varchar(255) NOT NULL,
  `subtype` varchar(256) NOT NULL,
  `hasReceivedSub` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `payments_paypal`
--

CREATE TABLE `payments_paypal` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(256) NOT NULL,
  `status` varchar(255) NOT NULL,
  `subtype` varchar(256) NOT NULL,
  `date` datetime NOT NULL,
  `discordToken` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `payments_reseller`
--

CREATE TABLE `payments_reseller` (
  `id` int NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoiceID` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `status` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hasReceivedKeys` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `scripts`
--

CREATE TABLE `scripts` (
  `id` int NOT NULL,
  `script` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `creator` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `scripts_vip`
--

CREATE TABLE `scripts_vip` (
  `id` int NOT NULL,
  `scriptName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `buyer` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `endSub` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `scripts_vip_key`
--

CREATE TABLE `scripts_vip_key` (
  `id` int NOT NULL,
  `scriptname` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `encryption_key` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `script_rating`
--

CREATE TABLE `script_rating` (
  `id` int NOT NULL,
  `script` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users_dashboard`
--

CREATE TABLE `users_dashboard` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users_lol`
--

CREATE TABLE `users_lol` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(256) NOT NULL,
  `hwid` varchar(255) NOT NULL,
  `regIP` varchar(255) NOT NULL,
  `lastIP` varchar(255) NOT NULL,
  `discordToken` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `startSub` datetime NOT NULL,
  `endSub` datetime NOT NULL,
  `zoomHackOnly` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `extend_codes`
--
ALTER TABLE `extend_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `init_codes`
--
ALTER TABLE `init_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `injected_scripts`
--
ALTER TABLE `injected_scripts`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `load_file`
--
ALTER TABLE `load_file`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `log_api`
--
ALTER TABLE `log_api`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `log_dashboard`
--
ALTER TABLE `log_dashboard`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `log_declined`
--
ALTER TABLE `log_declined`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `log_hwid`
--
ALTER TABLE `log_hwid`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `log_injected`
--
ALTER TABLE `log_injected`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `log_reset`
--
ALTER TABLE `log_reset`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `log_success`
--
ALTER TABLE `log_success`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `patch_lol`
--
ALTER TABLE `patch_lol`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `payments_paypal`
--
ALTER TABLE `payments_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `payments_reseller`
--
ALTER TABLE `payments_reseller`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `scripts`
--
ALTER TABLE `scripts`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `scripts_vip`
--
ALTER TABLE `scripts_vip`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `scripts_vip_key`
--
ALTER TABLE `scripts_vip_key`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `script_rating`
--
ALTER TABLE `script_rating`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `users_dashboard`
--
ALTER TABLE `users_dashboard`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `users_lol`
--
ALTER TABLE `users_lol`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `extend_codes`
--
ALTER TABLE `extend_codes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `init_codes`
--
ALTER TABLE `init_codes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `injected_scripts`
--
ALTER TABLE `injected_scripts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `load_file`
--
ALTER TABLE `load_file`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `log_api`
--
ALTER TABLE `log_api`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `log_dashboard`
--
ALTER TABLE `log_dashboard`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `log_declined`
--
ALTER TABLE `log_declined`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `log_hwid`
--
ALTER TABLE `log_hwid`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `log_injected`
--
ALTER TABLE `log_injected`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `log_reset`
--
ALTER TABLE `log_reset`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `log_success`
--
ALTER TABLE `log_success`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `patch_lol`
--
ALTER TABLE `patch_lol`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `payments_paypal`
--
ALTER TABLE `payments_paypal`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `payments_reseller`
--
ALTER TABLE `payments_reseller`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `scripts`
--
ALTER TABLE `scripts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `scripts_vip`
--
ALTER TABLE `scripts_vip`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `scripts_vip_key`
--
ALTER TABLE `scripts_vip_key`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `script_rating`
--
ALTER TABLE `script_rating`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `users_dashboard`
--
ALTER TABLE `users_dashboard`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `users_lol`
--
ALTER TABLE `users_lol`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
