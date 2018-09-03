/*
 Navicat Premium Data Transfer

 Source Server         : BD_Remoto
 Source Server Type    : SQLite
 Source Server Version : 3021000
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3021000
 File Encoding         : 65001

 Date: 02/09/2018 23:24:46
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for ENCCEJA_2018
-- ----------------------------
DROP TABLE IF EXISTS "ENCCEJA_2018";
CREATE TABLE "ENCCEJA_2018" (
  "Objeto" TEXT,
  "Data/Hora de postagem" TEXT,
  "Data Prevista" TEXT,
  "Data de Entrega" TEXT,
  "Objeto de retorno/ida" TEXT,
  "Cód. Destinatário" TEXT,
  "Destinatário" TEXT,
  "Logradouro" TEXT,
  "Bairro" TEXT,
  "CEP" TEXT,
  "Cód. Cidade" TEXT,
  "Cidade" TEXT,
  "UF" TEXT,
  "Último Status" TEXT,
  "SE" TEXT,
  "Cód. Centralizadora" TEXT,
  "Cód. Distribuidora" TEXT,
  "Distribuidora" TEXT,
  "Mala Postal" TEXT,
  "Tipo do unitizador" TEXT,
  "Sabadista (S/N)" TEXT,
  "Prova Especial (S/N)" TEXT,
  "Peso (em kg)" TEXT,
  "Núm. unitizador previsto" TEXT,
  "Qtd. inscritos" TEXT,
  "Qtd. provas" TEXT,
  "Qtd. provas especiais" TEXT,
  "Lacre 1" TEXT,
  "Lacre 2" TEXT,
  "Organizadora" TEXT,
  "Arquivo" TEXT,
  "Data/Hora envio arq p/ grafica" TEXT
);

-- ----------------------------
-- Table structure for Geo_busca
-- ----------------------------
DROP TABLE IF EXISTS "Geo_busca";
CREATE TABLE "Geo_busca" (
  "GEO_ID" INTEGER(255) NOT NULL,
  "Destinatario" TEXT(100),
  "Centralizadora" TEXT(10),
  "Bairro" TEXT(100),
  "Cidade" TEXT(100),
  "SE" TEXT(3),
  "UF" TEXT(3),
  "Pesquisa" TEXT(140),
  "Latitude" TEXT(30),
  "Longitude" TEXT(30),
  PRIMARY KEY ("GEO_ID")
);

-- ----------------------------
-- Table structure for Objetos
-- ----------------------------
DROP TABLE IF EXISTS "Objetos";
CREATE TABLE "Objetos" (
  "Objeto" TEXT(255) NOT NULL,
  "Data" TEXT(255),
  "GEO_ID" INTEGER(255),
  PRIMARY KEY ("Objeto")
);

PRAGMA foreign_keys = true;
