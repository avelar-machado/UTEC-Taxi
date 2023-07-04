-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 04-Jul-2023 às 00:19
-- Versão do servidor: 10.4.28-MariaDB
-- versão do PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `dbutec`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `email_cliente` varchar(255) NOT NULL,
  `localizacao_x` float NOT NULL,
  `localizacao_y` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`email_cliente`, `localizacao_x`, `localizacao_y`) VALUES
('pedro@gmail.com', 0, 0),
('reginaldo@gmail.com', 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `motoristas`
--

CREATE TABLE `motoristas` (
  `email_motorista` varchar(255) NOT NULL,
  `grau_cumprimento_horario` float DEFAULT NULL,
  `classificacao` int(11) DEFAULT NULL,
  `kms_realizados` float DEFAULT NULL,
  `disponibilidade` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Extraindo dados da tabela `motoristas`
--

INSERT INTO `motoristas` (`email_motorista`, `grau_cumprimento_horario`, `classificacao`, `kms_realizados`, `disponibilidade`) VALUES
('avelar@gmail.com', NULL, NULL, NULL, 1),
('oliver@gmail.com', NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizadores`
--

CREATE TABLE `utilizadores` (
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `morada` varchar(255) NOT NULL,
  `data_nascimento` date NOT NULL,
  `tipo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Extraindo dados da tabela `utilizadores`
--

INSERT INTO `utilizadores` (`nome`, `email`, `password`, `morada`, `data_nascimento`, `tipo`) VALUES
('Avelar Manuel', 'avelar@gmail.com', 'abc', 'Luanda', '2023-07-12', 'Motorista'),
('Oliver Deire', 'oliver@gmail.com', 'abc', 'Rangel', '2023-06-25', 'Motorista'),
('Pedro Manuel', 'pedro@gmail.com', 'abc', 'Cazenga', '2023-06-25', 'Motorista'),
('Reginaldo Machado', 'reginaldo@gmail.com', 'abc', 'Luanda', '2023-06-28', 'Cliente');

-- --------------------------------------------------------

--
-- Estrutura da tabela `veiculos`
--

CREATE TABLE `veiculos` (
  `id_veiculo` int(11) NOT NULL,
  `tipo_veiculo` varchar(255) NOT NULL,
  `velocidade_media_km` float NOT NULL,
  `preco_base_km` float NOT NULL,
  `factor_fiabilidade` float DEFAULT NULL,
  `localizacao_x` float NOT NULL,
  `localizacao_y` float NOT NULL,
  `fk_motorista` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Extraindo dados da tabela `veiculos`
--

INSERT INTO `veiculos` (`id_veiculo`, `tipo_veiculo`, `velocidade_media_km`, `preco_base_km`, `factor_fiabilidade`, `localizacao_x`, `localizacao_y`, `fk_motorista`) VALUES
(3, 'motos', 1000, 1000000, NULL, 2, 2, 'avelar@gmail.com'),
(4, 'carrinhas de nove lugares', 10000, 1000000, NULL, 1, 1, 'oliver@gmail.com');

-- --------------------------------------------------------

--
-- Estrutura da tabela `viagens`
--

CREATE TABLE `viagens` (
  `id_viagem` int(11) NOT NULL,
  `email_cliente` varchar(255) NOT NULL,
  `id_veiculo` int(11) NOT NULL,
  `coordenadas_origem_x` float NOT NULL,
  `coordenadas_origem_y` float NOT NULL,
  `coordenadas_destino_x` float NOT NULL,
  `coordenadas_destino_y` float NOT NULL,
  `custo_estimado` float NOT NULL,
  `custo_real` float NOT NULL,
  `tempo_estimado` float NOT NULL,
  `tempo_real` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`email_cliente`);

--
-- Índices para tabela `motoristas`
--
ALTER TABLE `motoristas`
  ADD PRIMARY KEY (`email_motorista`);

--
-- Índices para tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  ADD PRIMARY KEY (`email`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices para tabela `veiculos`
--
ALTER TABLE `veiculos`
  ADD PRIMARY KEY (`id_veiculo`),
  ADD KEY `fk_motorista` (`fk_motorista`);

--
-- Índices para tabela `viagens`
--
ALTER TABLE `viagens`
  ADD PRIMARY KEY (`id_viagem`),
  ADD KEY `email_cliente` (`email_cliente`),
  ADD KEY `id_veiculo` (`id_veiculo`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `veiculos`
--
ALTER TABLE `veiculos`
  MODIFY `id_veiculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `viagens`
--
ALTER TABLE `viagens`
  MODIFY `id_viagem` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`email_cliente`) REFERENCES `utilizadores` (`email`);

--
-- Limitadores para a tabela `motoristas`
--
ALTER TABLE `motoristas`
  ADD CONSTRAINT `motoristas_ibfk_1` FOREIGN KEY (`email_motorista`) REFERENCES `utilizadores` (`email`);

--
-- Limitadores para a tabela `veiculos`
--
ALTER TABLE `veiculos`
  ADD CONSTRAINT `veiculos_ibfk_1` FOREIGN KEY (`fk_motorista`) REFERENCES `motoristas` (`email_motorista`);

--
-- Limitadores para a tabela `viagens`
--
ALTER TABLE `viagens`
  ADD CONSTRAINT `viagens_ibfk_1` FOREIGN KEY (`email_cliente`) REFERENCES `clientes` (`email_cliente`),
  ADD CONSTRAINT `viagens_ibfk_2` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos` (`id_veiculo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
