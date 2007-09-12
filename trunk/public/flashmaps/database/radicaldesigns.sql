-- phpMyAdmin SQL Dump
-- version 2.7.0-pl2
-- http://www.phpmyadmin.net
-- 
-- Servidor: localhost
-- Tiempo de generación: 12-09-2007 a las 17:19:54
-- Versión del servidor: 5.0.27
-- Versión de PHP: 5.2.0
-- 
-- Base de datos: `radicaldesigns`
-- 

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `districts`
-- 

CREATE TABLE `districts` (
  `stateID` varchar(5) NOT NULL,
  `districtID` varchar(3) NOT NULL,
  `district` varchar(50) default NULL,
  PRIMARY KEY  (`stateID`,`districtID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Volcar la base de datos para la tabla `districts`
-- 

INSERT INTO `districts` VALUES ('us_ak', 'one', '00');
INSERT INTO `districts` VALUES ('us_al', '1', '01');
INSERT INTO `districts` VALUES ('us_al', '2', '02');
INSERT INTO `districts` VALUES ('us_al', '3', '03');
INSERT INTO `districts` VALUES ('us_al', '4', '04');
INSERT INTO `districts` VALUES ('us_al', '5', '05');
INSERT INTO `districts` VALUES ('us_al', '6', '06');
INSERT INTO `districts` VALUES ('us_al', '7', '07');
INSERT INTO `districts` VALUES ('us_ar', '1', '01');
INSERT INTO `districts` VALUES ('us_ar', '2', '02');
INSERT INTO `districts` VALUES ('us_ar', '3', '03');
INSERT INTO `districts` VALUES ('us_ar', '4', '04');
INSERT INTO `districts` VALUES ('us_az', '1', '01');
INSERT INTO `districts` VALUES ('us_az', '2', '02');
INSERT INTO `districts` VALUES ('us_az', '3', '03');
INSERT INTO `districts` VALUES ('us_az', '4', '04');
INSERT INTO `districts` VALUES ('us_az', '5', '05');
INSERT INTO `districts` VALUES ('us_az', '6', '06');
INSERT INTO `districts` VALUES ('us_az', '7', '07');
INSERT INTO `districts` VALUES ('us_az', '8', '08');
INSERT INTO `districts` VALUES ('us_ca', '1', '01');
INSERT INTO `districts` VALUES ('us_ca', '10', '10');
INSERT INTO `districts` VALUES ('us_ca', '11', '11');
INSERT INTO `districts` VALUES ('us_ca', '12', '12');
INSERT INTO `districts` VALUES ('us_ca', '13', '13');
INSERT INTO `districts` VALUES ('us_ca', '14', '14');
INSERT INTO `districts` VALUES ('us_ca', '15', '15');
INSERT INTO `districts` VALUES ('us_ca', '16', '16');
INSERT INTO `districts` VALUES ('us_ca', '17', '17');
INSERT INTO `districts` VALUES ('us_ca', '18', '18');
INSERT INTO `districts` VALUES ('us_ca', '19', '19');
INSERT INTO `districts` VALUES ('us_ca', '2', '02');
INSERT INTO `districts` VALUES ('us_ca', '20', '20');
INSERT INTO `districts` VALUES ('us_ca', '21', '21');
INSERT INTO `districts` VALUES ('us_ca', '22', '22');
INSERT INTO `districts` VALUES ('us_ca', '23', '23');
INSERT INTO `districts` VALUES ('us_ca', '24', '24');
INSERT INTO `districts` VALUES ('us_ca', '25', '25');
INSERT INTO `districts` VALUES ('us_ca', '26', '26');
INSERT INTO `districts` VALUES ('us_ca', '27', '27');
INSERT INTO `districts` VALUES ('us_ca', '28', '28');
INSERT INTO `districts` VALUES ('us_ca', '29', '29');
INSERT INTO `districts` VALUES ('us_ca', '3', '03');
INSERT INTO `districts` VALUES ('us_ca', '30', '30');
INSERT INTO `districts` VALUES ('us_ca', '31', '31');
INSERT INTO `districts` VALUES ('us_ca', '32', '32');
INSERT INTO `districts` VALUES ('us_ca', '33', '33');
INSERT INTO `districts` VALUES ('us_ca', '34', '34');
INSERT INTO `districts` VALUES ('us_ca', '35', '35');
INSERT INTO `districts` VALUES ('us_ca', '36', '36');
INSERT INTO `districts` VALUES ('us_ca', '37', '37');
INSERT INTO `districts` VALUES ('us_ca', '38', '38');
INSERT INTO `districts` VALUES ('us_ca', '39', '39');
INSERT INTO `districts` VALUES ('us_ca', '4', '04');
INSERT INTO `districts` VALUES ('us_ca', '40', '40');
INSERT INTO `districts` VALUES ('us_ca', '41', '41');
INSERT INTO `districts` VALUES ('us_ca', '42', '42');
INSERT INTO `districts` VALUES ('us_ca', '43', '43');
INSERT INTO `districts` VALUES ('us_ca', '44', '44');
INSERT INTO `districts` VALUES ('us_ca', '45', '45');
INSERT INTO `districts` VALUES ('us_ca', '46', '46');
INSERT INTO `districts` VALUES ('us_ca', '47', '47');
INSERT INTO `districts` VALUES ('us_ca', '48', '48');
INSERT INTO `districts` VALUES ('us_ca', '49', '49');
INSERT INTO `districts` VALUES ('us_ca', '5', '05');
INSERT INTO `districts` VALUES ('us_ca', '50', '50');
INSERT INTO `districts` VALUES ('us_ca', '51', '51');
INSERT INTO `districts` VALUES ('us_ca', '52', '52');
INSERT INTO `districts` VALUES ('us_ca', '53', '53');
INSERT INTO `districts` VALUES ('us_ca', '6', '06');
INSERT INTO `districts` VALUES ('us_ca', '7', '07');
INSERT INTO `districts` VALUES ('us_ca', '8', '08');
INSERT INTO `districts` VALUES ('us_ca', '9', '09');
INSERT INTO `districts` VALUES ('us_co', '1', '01');
INSERT INTO `districts` VALUES ('us_co', '2', '02');
INSERT INTO `districts` VALUES ('us_co', '3', '03');
INSERT INTO `districts` VALUES ('us_co', '4', '04');
INSERT INTO `districts` VALUES ('us_co', '5', '05');
INSERT INTO `districts` VALUES ('us_co', '6', '06');
INSERT INTO `districts` VALUES ('us_co', '7', '07');
INSERT INTO `districts` VALUES ('us_ct', '1', '01');
INSERT INTO `districts` VALUES ('us_ct', '2', '02');
INSERT INTO `districts` VALUES ('us_ct', '3', '03');
INSERT INTO `districts` VALUES ('us_ct', '4', '04');
INSERT INTO `districts` VALUES ('us_ct', '5', '05');
INSERT INTO `districts` VALUES ('us_dc', '98', '98');
INSERT INTO `districts` VALUES ('us_de', 'one', '00');
INSERT INTO `districts` VALUES ('us_fl', '1', '01');
INSERT INTO `districts` VALUES ('us_fl', '10', '10');
INSERT INTO `districts` VALUES ('us_fl', '11', '11');
INSERT INTO `districts` VALUES ('us_fl', '12', '12');
INSERT INTO `districts` VALUES ('us_fl', '13', '13');
INSERT INTO `districts` VALUES ('us_fl', '14', '14');
INSERT INTO `districts` VALUES ('us_fl', '15', '15');
INSERT INTO `districts` VALUES ('us_fl', '16', '16');
INSERT INTO `districts` VALUES ('us_fl', '17', '17');
INSERT INTO `districts` VALUES ('us_fl', '18', '18');
INSERT INTO `districts` VALUES ('us_fl', '19', '19');
INSERT INTO `districts` VALUES ('us_fl', '2', '02');
INSERT INTO `districts` VALUES ('us_fl', '20', '20');
INSERT INTO `districts` VALUES ('us_fl', '21', '21');
INSERT INTO `districts` VALUES ('us_fl', '22', '22');
INSERT INTO `districts` VALUES ('us_fl', '23', '23');
INSERT INTO `districts` VALUES ('us_fl', '24', '24');
INSERT INTO `districts` VALUES ('us_fl', '25', '25');
INSERT INTO `districts` VALUES ('us_fl', '3', '03');
INSERT INTO `districts` VALUES ('us_fl', '4', '04');
INSERT INTO `districts` VALUES ('us_fl', '5', '05');
INSERT INTO `districts` VALUES ('us_fl', '6', '06');
INSERT INTO `districts` VALUES ('us_fl', '7', '07');
INSERT INTO `districts` VALUES ('us_fl', '8', '08');
INSERT INTO `districts` VALUES ('us_fl', '9', '09');
INSERT INTO `districts` VALUES ('us_ga', '1', '01');
INSERT INTO `districts` VALUES ('us_ga', '10', '10');
INSERT INTO `districts` VALUES ('us_ga', '11', '11');
INSERT INTO `districts` VALUES ('us_ga', '12', '12');
INSERT INTO `districts` VALUES ('us_ga', '13', '13');
INSERT INTO `districts` VALUES ('us_ga', '2', '02');
INSERT INTO `districts` VALUES ('us_ga', '3', '03');
INSERT INTO `districts` VALUES ('us_ga', '4', '04');
INSERT INTO `districts` VALUES ('us_ga', '5', '05');
INSERT INTO `districts` VALUES ('us_ga', '6', '06');
INSERT INTO `districts` VALUES ('us_ga', '7', '07');
INSERT INTO `districts` VALUES ('us_ga', '8', '08');
INSERT INTO `districts` VALUES ('us_ga', '9', '09');
INSERT INTO `districts` VALUES ('us_hi', '1', '01');
INSERT INTO `districts` VALUES ('us_hi', '2', '02');
INSERT INTO `districts` VALUES ('us_ia', '1', '01');
INSERT INTO `districts` VALUES ('us_ia', '2', '02');
INSERT INTO `districts` VALUES ('us_ia', '3', '03');
INSERT INTO `districts` VALUES ('us_ia', '4', '04');
INSERT INTO `districts` VALUES ('us_ia', '5', '05');
INSERT INTO `districts` VALUES ('us_id', '1', '01');
INSERT INTO `districts` VALUES ('us_id', '2', '02');
INSERT INTO `districts` VALUES ('us_il', '1', '01');
INSERT INTO `districts` VALUES ('us_il', '10', '10');
INSERT INTO `districts` VALUES ('us_il', '11', '11');
INSERT INTO `districts` VALUES ('us_il', '12', '12');
INSERT INTO `districts` VALUES ('us_il', '13', '13');
INSERT INTO `districts` VALUES ('us_il', '14', '14');
INSERT INTO `districts` VALUES ('us_il', '15', '15');
INSERT INTO `districts` VALUES ('us_il', '16', '16');
INSERT INTO `districts` VALUES ('us_il', '17', '17');
INSERT INTO `districts` VALUES ('us_il', '18', '18');
INSERT INTO `districts` VALUES ('us_il', '19', '19');
INSERT INTO `districts` VALUES ('us_il', '2', '02');
INSERT INTO `districts` VALUES ('us_il', '3', '03');
INSERT INTO `districts` VALUES ('us_il', '4', '04');
INSERT INTO `districts` VALUES ('us_il', '5', '05');
INSERT INTO `districts` VALUES ('us_il', '6', '06');
INSERT INTO `districts` VALUES ('us_il', '7', '07');
INSERT INTO `districts` VALUES ('us_il', '8', '08');
INSERT INTO `districts` VALUES ('us_il', '9', '09');
INSERT INTO `districts` VALUES ('us_in', '1', '01');
INSERT INTO `districts` VALUES ('us_in', '2', '02');
INSERT INTO `districts` VALUES ('us_in', '3', '03');
INSERT INTO `districts` VALUES ('us_in', '4', '04');
INSERT INTO `districts` VALUES ('us_in', '5', '05');
INSERT INTO `districts` VALUES ('us_in', '6', '06');
INSERT INTO `districts` VALUES ('us_in', '7', '07');
INSERT INTO `districts` VALUES ('us_in', '8', '08');
INSERT INTO `districts` VALUES ('us_in', '9', '09');
INSERT INTO `districts` VALUES ('us_ks', '1', '01');
INSERT INTO `districts` VALUES ('us_ks', '2', '02');
INSERT INTO `districts` VALUES ('us_ks', '3', '03');
INSERT INTO `districts` VALUES ('us_ks', '4', '04');
INSERT INTO `districts` VALUES ('us_ky', '1', '01');
INSERT INTO `districts` VALUES ('us_ky', '2', '02');
INSERT INTO `districts` VALUES ('us_ky', '3', '03');
INSERT INTO `districts` VALUES ('us_ky', '4', '04');
INSERT INTO `districts` VALUES ('us_ky', '5', '05');
INSERT INTO `districts` VALUES ('us_ky', '6', '06');
INSERT INTO `districts` VALUES ('us_la', '1', '01');
INSERT INTO `districts` VALUES ('us_la', '2', '02');
INSERT INTO `districts` VALUES ('us_la', '3', '03');
INSERT INTO `districts` VALUES ('us_la', '4', '04');
INSERT INTO `districts` VALUES ('us_la', '5', '05');
INSERT INTO `districts` VALUES ('us_la', '6', '06');
INSERT INTO `districts` VALUES ('us_la', '7', '07');
INSERT INTO `districts` VALUES ('us_ma', '1', '01');
INSERT INTO `districts` VALUES ('us_ma', '10', '10');
INSERT INTO `districts` VALUES ('us_ma', '2', '02');
INSERT INTO `districts` VALUES ('us_ma', '3', '03');
INSERT INTO `districts` VALUES ('us_ma', '4', '04');
INSERT INTO `districts` VALUES ('us_ma', '5', '05');
INSERT INTO `districts` VALUES ('us_ma', '6', '06');
INSERT INTO `districts` VALUES ('us_ma', '7', '07');
INSERT INTO `districts` VALUES ('us_ma', '8', '08');
INSERT INTO `districts` VALUES ('us_ma', '9', '09');
INSERT INTO `districts` VALUES ('us_md', '1', '01');
INSERT INTO `districts` VALUES ('us_md', '2', '02');
INSERT INTO `districts` VALUES ('us_md', '3', '03');
INSERT INTO `districts` VALUES ('us_md', '4', '04');
INSERT INTO `districts` VALUES ('us_md', '5', '05');
INSERT INTO `districts` VALUES ('us_md', '6', '06');
INSERT INTO `districts` VALUES ('us_md', '7', '07');
INSERT INTO `districts` VALUES ('us_md', '8', '08');
INSERT INTO `districts` VALUES ('us_me', '1', '01');
INSERT INTO `districts` VALUES ('us_me', '2', '02');
INSERT INTO `districts` VALUES ('us_mi', '1', '01');
INSERT INTO `districts` VALUES ('us_mi', '10', '10');
INSERT INTO `districts` VALUES ('us_mi', '11', '11');
INSERT INTO `districts` VALUES ('us_mi', '12', '12');
INSERT INTO `districts` VALUES ('us_mi', '13', '13');
INSERT INTO `districts` VALUES ('us_mi', '14', '14');
INSERT INTO `districts` VALUES ('us_mi', '15', '15');
INSERT INTO `districts` VALUES ('us_mi', '2', '02');
INSERT INTO `districts` VALUES ('us_mi', '3', '03');
INSERT INTO `districts` VALUES ('us_mi', '4', '04');
INSERT INTO `districts` VALUES ('us_mi', '5', '05');
INSERT INTO `districts` VALUES ('us_mi', '6', '06');
INSERT INTO `districts` VALUES ('us_mi', '7', '07');
INSERT INTO `districts` VALUES ('us_mi', '8', '08');
INSERT INTO `districts` VALUES ('us_mi', '9', '09');
INSERT INTO `districts` VALUES ('us_mn', '1', '01');
INSERT INTO `districts` VALUES ('us_mn', '2', '02');
INSERT INTO `districts` VALUES ('us_mn', '3', '03');
INSERT INTO `districts` VALUES ('us_mn', '4', '04');
INSERT INTO `districts` VALUES ('us_mn', '5', '05');
INSERT INTO `districts` VALUES ('us_mn', '6', '06');
INSERT INTO `districts` VALUES ('us_mn', '7', '07');
INSERT INTO `districts` VALUES ('us_mn', '8', '08');
INSERT INTO `districts` VALUES ('us_mo', '1', '01');
INSERT INTO `districts` VALUES ('us_mo', '2', '02');
INSERT INTO `districts` VALUES ('us_mo', '3', '03');
INSERT INTO `districts` VALUES ('us_mo', '4', '04');
INSERT INTO `districts` VALUES ('us_mo', '5', '05');
INSERT INTO `districts` VALUES ('us_mo', '6', '06');
INSERT INTO `districts` VALUES ('us_mo', '7', '07');
INSERT INTO `districts` VALUES ('us_mo', '8', '08');
INSERT INTO `districts` VALUES ('us_mo', '9', '09');
INSERT INTO `districts` VALUES ('us_ms', '1', '01');
INSERT INTO `districts` VALUES ('us_ms', '2', '02');
INSERT INTO `districts` VALUES ('us_ms', '3', '03');
INSERT INTO `districts` VALUES ('us_ms', '4', '04');
INSERT INTO `districts` VALUES ('us_mt', 'one', '00');
INSERT INTO `districts` VALUES ('us_nc', '1', '01');
INSERT INTO `districts` VALUES ('us_nc', '10', '10');
INSERT INTO `districts` VALUES ('us_nc', '11', '11');
INSERT INTO `districts` VALUES ('us_nc', '12', '12');
INSERT INTO `districts` VALUES ('us_nc', '13', '13');
INSERT INTO `districts` VALUES ('us_nc', '2', '02');
INSERT INTO `districts` VALUES ('us_nc', '3', '03');
INSERT INTO `districts` VALUES ('us_nc', '4', '04');
INSERT INTO `districts` VALUES ('us_nc', '5', '05');
INSERT INTO `districts` VALUES ('us_nc', '6', '06');
INSERT INTO `districts` VALUES ('us_nc', '7', '07');
INSERT INTO `districts` VALUES ('us_nc', '8', '08');
INSERT INTO `districts` VALUES ('us_nc', '9', '09');
INSERT INTO `districts` VALUES ('us_nd', 'one', '00');
INSERT INTO `districts` VALUES ('us_ne', '1', '01');
INSERT INTO `districts` VALUES ('us_ne', '2', '02');
INSERT INTO `districts` VALUES ('us_ne', '3', '03');
INSERT INTO `districts` VALUES ('us_nh', '1', '01');
INSERT INTO `districts` VALUES ('us_nh', '2', '02');
INSERT INTO `districts` VALUES ('us_nj', '1', '01');
INSERT INTO `districts` VALUES ('us_nj', '10', '10');
INSERT INTO `districts` VALUES ('us_nj', '11', '11');
INSERT INTO `districts` VALUES ('us_nj', '12', '12');
INSERT INTO `districts` VALUES ('us_nj', '13', '13');
INSERT INTO `districts` VALUES ('us_nj', '2', '02');
INSERT INTO `districts` VALUES ('us_nj', '3', '03');
INSERT INTO `districts` VALUES ('us_nj', '4', '04');
INSERT INTO `districts` VALUES ('us_nj', '5', '05');
INSERT INTO `districts` VALUES ('us_nj', '6', '06');
INSERT INTO `districts` VALUES ('us_nj', '7', '07');
INSERT INTO `districts` VALUES ('us_nj', '8', '08');
INSERT INTO `districts` VALUES ('us_nj', '9', '09');
INSERT INTO `districts` VALUES ('us_nm', '1', '01');
INSERT INTO `districts` VALUES ('us_nm', '2', '02');
INSERT INTO `districts` VALUES ('us_nm', '3', '03');
INSERT INTO `districts` VALUES ('us_nv', '1', '01');
INSERT INTO `districts` VALUES ('us_nv', '2', '02');
INSERT INTO `districts` VALUES ('us_nv', '3', '03');
INSERT INTO `districts` VALUES ('us_ny', '1', '01');
INSERT INTO `districts` VALUES ('us_ny', '10', '10');
INSERT INTO `districts` VALUES ('us_ny', '11', '11');
INSERT INTO `districts` VALUES ('us_ny', '12', '12');
INSERT INTO `districts` VALUES ('us_ny', '13', '13');
INSERT INTO `districts` VALUES ('us_ny', '14', '14');
INSERT INTO `districts` VALUES ('us_ny', '15', '15');
INSERT INTO `districts` VALUES ('us_ny', '16', '16');
INSERT INTO `districts` VALUES ('us_ny', '17', '17');
INSERT INTO `districts` VALUES ('us_ny', '18', '18');
INSERT INTO `districts` VALUES ('us_ny', '19', '19');
INSERT INTO `districts` VALUES ('us_ny', '2', '02');
INSERT INTO `districts` VALUES ('us_ny', '20', '20');
INSERT INTO `districts` VALUES ('us_ny', '21', '21');
INSERT INTO `districts` VALUES ('us_ny', '22', '22');
INSERT INTO `districts` VALUES ('us_ny', '23', '23');
INSERT INTO `districts` VALUES ('us_ny', '24', '24');
INSERT INTO `districts` VALUES ('us_ny', '25', '25');
INSERT INTO `districts` VALUES ('us_ny', '26', '26');
INSERT INTO `districts` VALUES ('us_ny', '27', '27');
INSERT INTO `districts` VALUES ('us_ny', '28', '28');
INSERT INTO `districts` VALUES ('us_ny', '29', '29');
INSERT INTO `districts` VALUES ('us_ny', '3', '03');
INSERT INTO `districts` VALUES ('us_ny', '4', '04');
INSERT INTO `districts` VALUES ('us_ny', '5', '05');
INSERT INTO `districts` VALUES ('us_ny', '6', '06');
INSERT INTO `districts` VALUES ('us_ny', '7', '07');
INSERT INTO `districts` VALUES ('us_ny', '8', '08');
INSERT INTO `districts` VALUES ('us_ny', '9', '09');
INSERT INTO `districts` VALUES ('us_oh', '1', '01');
INSERT INTO `districts` VALUES ('us_oh', '10', '10');
INSERT INTO `districts` VALUES ('us_oh', '11', '11');
INSERT INTO `districts` VALUES ('us_oh', '12', '12');
INSERT INTO `districts` VALUES ('us_oh', '13', '13');
INSERT INTO `districts` VALUES ('us_oh', '14', '14');
INSERT INTO `districts` VALUES ('us_oh', '15', '15');
INSERT INTO `districts` VALUES ('us_oh', '16', '16');
INSERT INTO `districts` VALUES ('us_oh', '17', '17');
INSERT INTO `districts` VALUES ('us_oh', '18', '18');
INSERT INTO `districts` VALUES ('us_oh', '2', '02');
INSERT INTO `districts` VALUES ('us_oh', '3', '03');
INSERT INTO `districts` VALUES ('us_oh', '4', '04');
INSERT INTO `districts` VALUES ('us_oh', '5', '05');
INSERT INTO `districts` VALUES ('us_oh', '6', '06');
INSERT INTO `districts` VALUES ('us_oh', '7', '07');
INSERT INTO `districts` VALUES ('us_oh', '8', '08');
INSERT INTO `districts` VALUES ('us_oh', '9', '09');
INSERT INTO `districts` VALUES ('us_ok', '1', '01');
INSERT INTO `districts` VALUES ('us_ok', '2', '02');
INSERT INTO `districts` VALUES ('us_ok', '3', '03');
INSERT INTO `districts` VALUES ('us_ok', '4', '04');
INSERT INTO `districts` VALUES ('us_ok', '5', '05');
INSERT INTO `districts` VALUES ('us_or', '1', '01');
INSERT INTO `districts` VALUES ('us_or', '2', '02');
INSERT INTO `districts` VALUES ('us_or', '3', '03');
INSERT INTO `districts` VALUES ('us_or', '4', '04');
INSERT INTO `districts` VALUES ('us_or', '5', '05');
INSERT INTO `districts` VALUES ('us_pa', '1', '01');
INSERT INTO `districts` VALUES ('us_pa', '10', '10');
INSERT INTO `districts` VALUES ('us_pa', '11', '11');
INSERT INTO `districts` VALUES ('us_pa', '12', '12');
INSERT INTO `districts` VALUES ('us_pa', '13', '13');
INSERT INTO `districts` VALUES ('us_pa', '14', '14');
INSERT INTO `districts` VALUES ('us_pa', '15', '15');
INSERT INTO `districts` VALUES ('us_pa', '16', '16');
INSERT INTO `districts` VALUES ('us_pa', '17', '17');
INSERT INTO `districts` VALUES ('us_pa', '18', '18');
INSERT INTO `districts` VALUES ('us_pa', '19', '19');
INSERT INTO `districts` VALUES ('us_pa', '2', '02');
INSERT INTO `districts` VALUES ('us_pa', '3', '03');
INSERT INTO `districts` VALUES ('us_pa', '4', '04');
INSERT INTO `districts` VALUES ('us_pa', '5', '05');
INSERT INTO `districts` VALUES ('us_pa', '6', '06');
INSERT INTO `districts` VALUES ('us_pa', '7', '07');
INSERT INTO `districts` VALUES ('us_pa', '8', '08');
INSERT INTO `districts` VALUES ('us_pa', '9', '09');
INSERT INTO `districts` VALUES ('us_pr', '98', '98');
INSERT INTO `districts` VALUES ('us_ri', '1', '01');
INSERT INTO `districts` VALUES ('us_ri', '2', '02');
INSERT INTO `districts` VALUES ('us_sc', '1', '01');
INSERT INTO `districts` VALUES ('us_sc', '2', '02');
INSERT INTO `districts` VALUES ('us_sc', '3', '03');
INSERT INTO `districts` VALUES ('us_sc', '4', '04');
INSERT INTO `districts` VALUES ('us_sc', '5', '05');
INSERT INTO `districts` VALUES ('us_sc', '6', '06');
INSERT INTO `districts` VALUES ('us_sd', 'one', '00');
INSERT INTO `districts` VALUES ('us_tn', '1', '01');
INSERT INTO `districts` VALUES ('us_tn', '2', '02');
INSERT INTO `districts` VALUES ('us_tn', '3', '03');
INSERT INTO `districts` VALUES ('us_tn', '4', '04');
INSERT INTO `districts` VALUES ('us_tn', '5', '05');
INSERT INTO `districts` VALUES ('us_tn', '6', '06');
INSERT INTO `districts` VALUES ('us_tn', '7', '07');
INSERT INTO `districts` VALUES ('us_tn', '8', '08');
INSERT INTO `districts` VALUES ('us_tn', '9', '09');
INSERT INTO `districts` VALUES ('us_tx', '1', '01');
INSERT INTO `districts` VALUES ('us_tx', '10', '10');
INSERT INTO `districts` VALUES ('us_tx', '11', '11');
INSERT INTO `districts` VALUES ('us_tx', '12', '12');
INSERT INTO `districts` VALUES ('us_tx', '13', '13');
INSERT INTO `districts` VALUES ('us_tx', '14', '14');
INSERT INTO `districts` VALUES ('us_tx', '15', '15');
INSERT INTO `districts` VALUES ('us_tx', '16', '16');
INSERT INTO `districts` VALUES ('us_tx', '17', '17');
INSERT INTO `districts` VALUES ('us_tx', '18', '18');
INSERT INTO `districts` VALUES ('us_tx', '19', '19');
INSERT INTO `districts` VALUES ('us_tx', '2', '02');
INSERT INTO `districts` VALUES ('us_tx', '20', '20');
INSERT INTO `districts` VALUES ('us_tx', '21', '21');
INSERT INTO `districts` VALUES ('us_tx', '22', '22');
INSERT INTO `districts` VALUES ('us_tx', '23', '23');
INSERT INTO `districts` VALUES ('us_tx', '24', '24');
INSERT INTO `districts` VALUES ('us_tx', '25', '25');
INSERT INTO `districts` VALUES ('us_tx', '26', '26');
INSERT INTO `districts` VALUES ('us_tx', '27', '27');
INSERT INTO `districts` VALUES ('us_tx', '28', '28');
INSERT INTO `districts` VALUES ('us_tx', '29', '29');
INSERT INTO `districts` VALUES ('us_tx', '3', '03');
INSERT INTO `districts` VALUES ('us_tx', '30', '30');
INSERT INTO `districts` VALUES ('us_tx', '31', '31');
INSERT INTO `districts` VALUES ('us_tx', '32', '32');
INSERT INTO `districts` VALUES ('us_tx', '4', '04');
INSERT INTO `districts` VALUES ('us_tx', '5', '05');
INSERT INTO `districts` VALUES ('us_tx', '6', '06');
INSERT INTO `districts` VALUES ('us_tx', '7', '07');
INSERT INTO `districts` VALUES ('us_tx', '8', '08');
INSERT INTO `districts` VALUES ('us_tx', '9', '09');
INSERT INTO `districts` VALUES ('us_ut', '1', '01');
INSERT INTO `districts` VALUES ('us_ut', '2', '02');
INSERT INTO `districts` VALUES ('us_ut', '3', '03');
INSERT INTO `districts` VALUES ('us_va', '1', '01');
INSERT INTO `districts` VALUES ('us_va', '10', '10');
INSERT INTO `districts` VALUES ('us_va', '11', '11');
INSERT INTO `districts` VALUES ('us_va', '2', '02');
INSERT INTO `districts` VALUES ('us_va', '3', '03');
INSERT INTO `districts` VALUES ('us_va', '4', '04');
INSERT INTO `districts` VALUES ('us_va', '5', '05');
INSERT INTO `districts` VALUES ('us_va', '6', '06');
INSERT INTO `districts` VALUES ('us_va', '7', '07');
INSERT INTO `districts` VALUES ('us_va', '8', '08');
INSERT INTO `districts` VALUES ('us_va', '9', '09');
INSERT INTO `districts` VALUES ('us_vt', 'one', '00');
INSERT INTO `districts` VALUES ('us_wa', '1', '01');
INSERT INTO `districts` VALUES ('us_wa', '2', '02');
INSERT INTO `districts` VALUES ('us_wa', '3', '03');
INSERT INTO `districts` VALUES ('us_wa', '4', '04');
INSERT INTO `districts` VALUES ('us_wa', '5', '05');
INSERT INTO `districts` VALUES ('us_wa', '6', '06');
INSERT INTO `districts` VALUES ('us_wa', '7', '07');
INSERT INTO `districts` VALUES ('us_wa', '8', '08');
INSERT INTO `districts` VALUES ('us_wa', '9', '09');
INSERT INTO `districts` VALUES ('us_wi', '1', '01');
INSERT INTO `districts` VALUES ('us_wi', '2', '02');
INSERT INTO `districts` VALUES ('us_wi', '3', '03');
INSERT INTO `districts` VALUES ('us_wi', '4', '04');
INSERT INTO `districts` VALUES ('us_wi', '5', '05');
INSERT INTO `districts` VALUES ('us_wi', '6', '06');
INSERT INTO `districts` VALUES ('us_wi', '7', '07');
INSERT INTO `districts` VALUES ('us_wi', '8', '08');
INSERT INTO `districts` VALUES ('us_wv', '1', '01');
INSERT INTO `districts` VALUES ('us_wv', '2', '02');
INSERT INTO `districts` VALUES ('us_wv', '3', '03');
INSERT INTO `districts` VALUES ('us_wy', 'one', '00');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `events`
-- 

CREATE TABLE `events` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `url` varchar(64) default NULL,
  `location` text,
  `city` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `postal_code` varchar(255) default NULL,
  `start` datetime default NULL,
  `end` datetime default NULL,
  `latitude` float default NULL,
  `longitude` float default NULL,
  `directions` text,
  `district` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_events_on_latitude_and_longitude` (`latitude`,`longitude`),
  KEY `index_events_on_postal_code` (`postal_code`),
  KEY `index_events_on_state_and_city` (`state`,`city`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=2135 ;

-- 
-- Volcar la base de datos para la tabla `events`
-- 

INSERT INTO `events` VALUES (2113, 'Who''s an Upper Valley Leader?', 'http://events/stepitup2007.org/nov/events/show/2113', '37 Highland Ave.\r\n', 'White River Junction', 'VT', '05001', '2007-11-03 13:00:00', '2007-11-03 16:00:00', 43.6563, -72.317, 'Hartford High School (VERY tentatively)', 'VT01');
INSERT INTO `events` VALUES (2114, 'Public Rally in Honor of Fred Schmeeckle', 'http://events/stepitup2007.org/nov/events/show/2114', '2419 North Point Drive\r\n', 'Stevens Point', 'WI', '54481', '2007-11-03 14:00:00', '2007-11-03 15:00:00', 44.5371, -89.5516, 'Take Highway 10 to Michigan Avenue in Stevens Point. Take Michigan Avenue North to North Point Drive. Turn right on North Point Drive and drive/bike past the Visitor Center to the parking lot on your right.', 'WI07');
INSERT INTO `events` VALUES (2115, 'Step It Up New Boston', 'http://events/stepitup2007.org/nov/events/show/2115', 'New Boston Village', 'New Boston', 'NH', '03070', '2007-11-10 12:00:00', '2007-11-06 12:00:00', 42.9778, -71.6856, 'Rte 13\r\nNew Boston Village\r\nNew Boston NH Look for signs.', 'NH02');
INSERT INTO `events` VALUES (2116, 'Test', 'http://events/stepitup2007.org/nov/events/show/2116', '330 Bridge St', 'Manchester', 'NH', '03104', '2007-11-03 12:00:00', '2007-11-03 14:00:00', 42.9956, -71.4478, 'test', 'NH01');
INSERT INTO `events` VALUES (2117, 'Carlsbad Village Drive...TBA', 'http://events/stepitup2007.org/nov/events/show/2117', '3067 Roosevelt St', 'Carlsbad', 'CA', '92008', '2007-11-03 12:00:00', '2007-11-03 14:00:00', 33.1594, -117.347, 'Take Carlsbad Village Drive exit west from the five, exact location TBA.', 'CA50');
INSERT INTO `events` VALUES (2118, 'Step it Up - Wilmington', 'http://events/stepitup2007.org/nov/events/show/2118', '1908 Kynwyd Road', 'Wilmington', 'DE', '19810', '2007-11-03 12:00:00', '2007-11-03 14:00:00', 39.8078, -75.5078, 'To be determined.', 'DE01');
INSERT INTO `events` VALUES (2119, 'Undecided', 'http://events/stepitup2007.org/nov/events/show/2119', '1011 SW 12th Ave.', 'Portland', 'OR', '97205', '2007-11-03 03:00:00', '2007-11-03 03:00:00', 45.5185, -122.685, 'TBD', 'OR01');
INSERT INTO `events` VALUES (2120, 'Mid-Atlantic Demonstration of United for Peace & Justice Day', 'http://events/stepitup2007.org/nov/events/show/2120', 'Independence Mall, Market St.', 'Philadelphia', 'PA', '19106', '2007-10-27 00:00:00', '2007-10-27 00:00:00', 39.9503, -75.1465, 'This is an exploratory posting for Oct. 27, instead of starting a new group for a Nov. 3 new action (which I just do not have time to do this fall...)', 'PA01');
INSERT INTO `events` VALUES (2121, 'STEPPING UP on FIFTH', 'http://events/stepitup2007.org/nov/events/show/2121', 'FIFTH AVENUE', 'Naples', 'FL', '34102', '2007-11-03 12:00:00', '2007-11-03 14:00:00', 26.1528, -81.7962, 'Follow Tamiami Trail to Fifth Avenue', 'FL14');
INSERT INTO `events` VALUES (2122, 'Test Action', 'http://events/stepitup2007.org/nov/events/show/2122', '931 Elm St', 'Manchester', 'NH', '03104', '2007-11-03 12:00:00', '2007-11-03 14:00:00', 42.9913, -71.4631, 'Test Directions', 'NH01');
INSERT INTO `events` VALUES (2123, 'End global warming/End the war', 'http://events/stepitup2007.org/nov/events/show/2123', '77 N. Lake Ave.', 'Pasadena', 'CA', '91106', '2007-11-02 02:00:00', '2007-11-03 14:00:00', 34.1471, -118.132, 'The event will take place north of 77 N. Lake Ave., on Lake at the 210 Freeway in pasadena.   (I son''t understand the boxes below.  Please redisign to make this clear.', 'CA26');
INSERT INTO `events` VALUES (2124, 'Step It Up 2007 #2 - NO NEW COAL!!!', 'http://events/stepitup2007.org/nov/events/show/2124', '1 Varsity St.', 'Brevard', 'NC', '28768', '2007-11-03 10:00:00', '2007-11-03 16:00:00', 35.2294, -82.7373, 'Through city of Brevard South on Broad Street to left on Varsity St.', 'NC11');
INSERT INTO `events` VALUES (2125, 'Step It Up Sierra!', 'http://events/stepitup2007.org/nov/events/show/2125', '5007 Fairgrounds Rd.\r\n\r\n', 'Mariposa', 'CA', '95338', '2007-11-03 03:00:00', '2007-11-03 03:00:00', 37.4629, -119.949, 'off of highway 49S\r\nMaiposa, CA\r\n', 'CA19');
INSERT INTO `events` VALUES (2126, 'Step It Up Central Susquehanna Valley II', 'http://events/stepitup2007.org/nov/events/show/2126', 'Moore Avenue\r\n', 'Lewisburg', 'PA', '17837', '2007-11-03 13:00:00', '2007-11-03 19:00:00', 40.9549, -76.887, 'The event will be in room 241 A, B, and C of the Langone Center at Bucknell University. \r\n\r\nThe Bucknell campus is off of Rt 15 one mile south of Rt 45.  At the intersection of Rt 15 with Moore Avenue/Smoketown Rd, head east on Moore.  On street parking is available on Moore.  The Langone Center is on the right, several hundred yards down.  The building entrance faces the intersection of Moore and S 7th St.  The room is on the east end of the second floor, just inboard of the terrace room.', 'PA10');
INSERT INTO `events` VALUES (2127, 'Urban Forest Restoration Project', 'http://events/stepitup2007.org/nov/events/show/2127', '14th Ave. SW & SW Holly St.  ', 'Seattle', 'WA', '98106', '2007-11-03 12:00:00', '2007-11-03 14:00:00', 47.5428, -122.353, 'Directions to the trailhead at the corner of 14th Ave. SW & SW Holly St. in\r\nWest Seattle.\r\n\r\nFrom I-5 or Route 99 (heading north or south):\r\n\r\nô€ƒ– Take the West Seattle Bridge exit off either highway.\r\n\r\nô€ƒ– From the bridge take the Delridge Way SW/South Seattle Comm. College\r\nexit (right hand exit)\r\n\r\nô€ƒ– The exit will wind around to the left & turn into Delridge Way, travel south\r\non Delridge to the third light (follow signs to SSCC)\r\n\r\nô€ƒ– At light (just past the pedestrian overpass), turn left onto SW Oregon St.\r\n\r\nô€ƒ– Follow this hilly arterial street as it winds around and eventually makes a\r\nhairpin turn to the right and turns into 16th Ave. SW\r\n\r\nô€ƒ– Follow 16th Ave. SW and after Â¼ mile SSCC will be on the left hand side.\r\n\r\nô€ƒ– Three blocks past the college take a left on SW Myrtle St.\r\n\r\nô€ƒ– Take a left on 14th Ave. SW and follow until it ends at SW Holly St. â€“ street\r\nparking should be available\r\n(Nature Consortium staff will be there to meet you.)', 'WA07');
INSERT INTO `events` VALUES (2128, 'Urban Forest Restoration Project', 'http://events/stepitup2007.org/nov/events/show/2128', ' 14th Ave. SW & SW Holly St.  ', 'Seattle', 'WA', '98106', '2007-11-03 12:00:00', '2007-11-03 14:00:00', 47.5428, -122.353, 'Directions to the trailhead at the corner of 14th Ave. SW & SW Holly St. in\r\nWest Seattle.\r\n\r\nFrom I-5 or Route 99 (heading north or south):\r\n\r\nô€ƒ– Take the West Seattle Bridge exit off either highway.\r\n\r\nô€ƒ– From the bridge take the Delridge Way SW/South Seattle Comm. College\r\nexit (right hand exit)\r\n\r\nô€ƒ– The exit will wind around to the left & turn into Delridge Way, travel south\r\non Delridge to the third light (follow signs to SSCC)\r\n\r\nô€ƒ– At light (just past the pedestrian overpass), turn left onto SW Oregon St.\r\n\r\nô€ƒ– Follow this hilly arterial street as it winds around and eventually makes a\r\nhairpin turn to the right and turns into 16th Ave. SW\r\n\r\nô€ƒ– Follow 16th Ave. SW and after Â¼ mile SSCC will be on the left hand side.\r\n\r\nô€ƒ– Three blocks past the college take a left on SW Myrtle St.\r\n\r\nô€ƒ– Take a left on 14th Ave. SW and follow until it ends at SW Holly St. â€“ street\r\nparking should be available\r\n(Nature Consortium staff will be there to meet you.)', 'WA07');
INSERT INTO `events` VALUES (2129, 'Step it up Fordham', 'http://events/stepitup2007.org/nov/events/show/2129', '155 West 60 St.', 'New York', 'NY', '10023', '2007-11-03 03:00:00', '2007-11-03 03:00:00', 40.7705, -73.9859, '(action to take place for Fordham students and residents only; no outsiders permitted on campus)', 'NY08');
INSERT INTO `events` VALUES (2132, 'Pitzer College: Step It Up!', 'http://events/stepitup2007.org/nov/events/show/2132', '1050 N Mills Ave #775', 'Claremont', 'CA', '91711', '2007-09-11 09:00:00', '2007-11-03 03:00:00', 34.1043, -117.707, '210 west\r\nfoothill west\r\nleft on claremont blvd\r\nleft on 9th ave', 'CA26');
INSERT INTO `events` VALUES (2133, 'Pitzer College: Step It Up!', 'http://events/stepitup2007.org/nov/events/show/2133', '1050 N Mills Ave #775', 'Claremont', 'CA', '91711', '2007-09-11 09:00:00', '2007-11-03 03:00:00', 34.1043, -117.707, '210 west\r\nfoothill west\r\nleft on claremont blvd\r\nleft on 9th ave', 'CA26');
INSERT INTO `events` VALUES (2134, 'Petition', 'http://events/stepitup2007.org/nov/events/show/2134', '1170 Logan St ', 'Denver', 'CO', '80203', '2002-11-03 12:00:00', '2002-11-03 14:00:00', 39.7347, -104.982, 'In Cap Hill', 'CO01');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `politician_invites`
-- 

CREATE TABLE `politician_invites` (
  `id` int(11) NOT NULL auto_increment,
  `politician_id` int(11) default NULL,
  `event_id` int(11) default NULL,
  `attending` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

-- 
-- Volcar la base de datos para la tabla `politician_invites`
-- 

INSERT INTO `politician_invites` VALUES (1, 924, 2117, 1);
INSERT INTO `politician_invites` VALUES (2, 923, 2117, 1);
INSERT INTO `politician_invites` VALUES (3, 921, 2117, NULL);
INSERT INTO `politician_invites` VALUES (4, 904, 2123, NULL);
INSERT INTO `politician_invites` VALUES (5, 924, 2123, NULL);
INSERT INTO `politician_invites` VALUES (6, 1141, 2115, NULL);
INSERT INTO `politician_invites` VALUES (7, 1144, 2115, 1);
INSERT INTO `politician_invites` VALUES (8, 1248, 2126, 1);
INSERT INTO `politician_invites` VALUES (9, 1261, 2126, NULL);
INSERT INTO `politician_invites` VALUES (10, 1264, 2120, 1);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `politicians`
-- 

CREATE TABLE `politicians` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `district` varchar(255) default NULL,
  `districtID` varchar(3) default NULL,
  `display_name` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `postal_code` varchar(255) default NULL,
  `district_type` varchar(255) default NULL,
  `image_url` varchar(255) default NULL,
  `website` varchar(255) default NULL,
  `party` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1381 ;

-- 
-- Volcar la base de datos para la tabla `politicians`
-- 

INSERT INTO `politicians` VALUES (834, NULL, 'Jo', 'Bonner', 'AL01', '1', 'Rep. Jo Bonner', '(202) 225-4931', 'http://bonner.house.gov/HoR/AL01/Contact+Us/Contact+Zip+Code.htm', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001244.jpg', 'http://bonner.house.gov/', 'R');
INSERT INTO `politicians` VALUES (835, NULL, 'Terry', 'Everett', 'AL02', '2', 'Rep. Terry Everett', '(202) 225-2901', 'http://wwwc.house.gov/everett/contact/email.asp', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000268.jpg', 'http://www.house.gov/everett/', 'R');
INSERT INTO `politicians` VALUES (836, NULL, 'Mike', 'Rogers', 'AL03', '3', 'Rep. Mike Rogers', '(202) 225-3261', 'http://www.house.gov/mike-rogers/contact/', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000575.jpg', 'http://www.house.gov/mike-rogers/', 'R');
INSERT INTO `politicians` VALUES (837, NULL, 'Robert', 'Aderholt', 'AL04', '4', 'Rep. Bob Aderholt', '(202) 225-4876', 'http://aderholt.house.gov/IQ_email.shtml', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000055.jpg', 'http://aderholt.house.gov/', 'R');
INSERT INTO `politicians` VALUES (838, NULL, 'Robert', 'Cramer', 'AL05', '5', 'Rep. Bud Cramer', '(202) 225-4801', 'budmail@mail.house.gov', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000868.jpg', 'http://cramer.house.gov/HoR/AL05/', 'D');
INSERT INTO `politicians` VALUES (839, NULL, 'Spencer', 'Bachus', 'AL06', '6', 'Rep. Spencer Bachus', '(202) 225-4921', 'http://www.house.gov/writerep/', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000013.jpg', 'http://bachus.house.gov/', 'R');
INSERT INTO `politicians` VALUES (840, NULL, 'Artur', 'Davis', 'AL07', '7', 'Rep. Artur Davis', '(202) 225-2665', 'http://www.house.gov/arturdavis/zipauth.shtml', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000136.jpg', 'http://www.house.gov/arturdavis/', 'D');
INSERT INTO `politicians` VALUES (841, NULL, 'Jo', 'Bonner', 'AL01', '1', 'Rep. Jo Bonner', '(202) 225-4931', 'http://bonner.house.gov/HoR/AL01/Contact+Us/Contact+Zip+Code.htm', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001244.jpg', 'http://bonner.house.gov/', 'R');
INSERT INTO `politicians` VALUES (842, NULL, 'Terry', 'Everett', 'AL02', '2', 'Rep. Terry Everett', '(202) 225-2901', 'http://wwwc.house.gov/everett/contact/email.asp', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000268.jpg', 'http://www.house.gov/everett/', 'R');
INSERT INTO `politicians` VALUES (843, NULL, 'Mike', 'Rogers', 'AL03', '3', 'Rep. Mike Rogers', '(202) 225-3261', 'http://www.house.gov/mike-rogers/contact/', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000575.jpg', 'http://www.house.gov/mike-rogers/', 'R');
INSERT INTO `politicians` VALUES (844, NULL, 'Robert', 'Aderholt', 'AL04', '4', 'Rep. Bob Aderholt', '(202) 225-4876', 'http://aderholt.house.gov/IQ_email.shtml', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000055.jpg', 'http://aderholt.house.gov/', 'R');
INSERT INTO `politicians` VALUES (845, NULL, 'Robert', 'Cramer', 'AL05', '5', 'Rep. Bud Cramer', '(202) 225-4801', 'budmail@mail.house.gov', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000868.jpg', 'http://cramer.house.gov/HoR/AL05/', 'D');
INSERT INTO `politicians` VALUES (846, NULL, 'Spencer', 'Bachus', 'AL06', '6', 'Rep. Spencer Bachus', '(202) 225-4921', 'http://www.house.gov/writerep/', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000013.jpg', 'http://bachus.house.gov/', 'R');
INSERT INTO `politicians` VALUES (847, NULL, 'Artur', 'Davis', 'AL07', '7', 'Rep. Artur Davis', '(202) 225-2665', 'http://www.house.gov/arturdavis/zipauth.shtml', NULL, 'AL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000136.jpg', 'http://www.house.gov/arturdavis/', 'D');
INSERT INTO `politicians` VALUES (848, NULL, 'Richard', 'Shelby', 'AL1', '1', 'Sen. Richard Shelby', '(202) 224-5744', 'http://shelby.senate.gov/resources/contact.htm', NULL, 'AL', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S000320.jpg', 'http://shelby.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (849, NULL, 'Jeff', 'Sessions', 'AL2', '2', 'Sen. Jeff Sessions', '(202) 224-4124', 'http://sessions.senate.gov/email/contact.cfm', NULL, 'AL', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S001141.jpg', 'http://sessions.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (850, NULL, 'Donald', 'Young', 'AK01', 'one', 'Rep. Don Young', '(202) 225-5765', 'http://donyoung.house.gov/opinions.htm', NULL, 'AK', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/Y/Y000033.jpg', 'http://donyoung.house.gov', 'R');
INSERT INTO `politicians` VALUES (851, NULL, 'Ted', 'Stevens', 'AK1', '1', 'Sen. Ted Stevens', '(202) 224-3004', 'http://stevens.senate.gov/contact.cfm', NULL, 'AK', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S000888.jpg', 'http://stevens.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (852, NULL, 'Lisa', 'Murkowski', 'AK2', '2', 'Sen. Lisa Murkowski', '(202) 224-6665', 'http://murkowski.senate.gov/contact.cfm#form', NULL, 'AK', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/M/M001153.jpg', 'http://Murkowski.Senate.gov', 'R');
INSERT INTO `politicians` VALUES (853, NULL, 'Eni', 'Faleomavaega', 'AS01', '1', 'Del. Eni Faleomavaega', '(202) 225-8577', 'Faleomavaega@mail.house.gov', NULL, 'AS', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000010.jpg', 'http://www.house.gov/faleomavaega/', 'D');
INSERT INTO `politicians` VALUES (854, NULL, 'Rick', 'Renzi', 'AZ01', '1', 'Rep. Rick Renzi', '(202) 225-2315', 'rick.renzi@mail.house.gov', NULL, 'AZ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000574.jpg', 'http://www.house.gov/renzi/', 'R');
INSERT INTO `politicians` VALUES (855, NULL, 'Trent', 'Franks', 'AZ02', '2', 'Rep. Trent Franks', '(202) 225-4576', 'http://www.house.gov/writerep/', NULL, 'AZ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000448.jpg', 'http://www.house.gov/franks/', 'R');
INSERT INTO `politicians` VALUES (856, NULL, 'John', 'Shadegg', 'AZ03', '3', 'Rep. John Shadegg', '(202) 225-3361', 'http://www.house.gov/formshadegg/emailtemplate.htm', NULL, 'AZ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000275.jpg', 'http://johnshadegg.house.gov', 'R');
INSERT INTO `politicians` VALUES (857, NULL, 'Ed', 'Pastor', 'AZ04', '4', 'Rep. Ed Pastor', '(202) 225-4065', 'http://www.house.gov/writerep/', NULL, 'AZ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000099.jpg', 'http://www.house.gov/pastor/', 'D');
INSERT INTO `politicians` VALUES (858, NULL, 'Harry', 'Mitchell', 'AZ05', '5', 'Rep. Harry Mitchell', '(202) 225-2190', NULL, NULL, 'AZ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001167.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (859, NULL, 'Jeff', 'Flake', 'AZ06', '6', 'Rep. Jeff Flake', '(202) 225-2635', 'jeff.flake@mail.house.gov', NULL, 'AZ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000444.jpg', 'http://www.house.gov/flake/', 'R');
INSERT INTO `politicians` VALUES (860, NULL, 'Raul', 'Grijalva', 'AZ07', '7', 'Rep. Raul Grijalva', '(202) 225-2435', 'http://www.house.gov/writerep/', NULL, 'AZ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000551.jpg', 'http://www.house.gov/grijalva/', 'D');
INSERT INTO `politicians` VALUES (861, NULL, 'Gabrielle', 'Giffords', 'AZ08', '8', 'Rep. Gabrielle Giffords', '(202) 225-2542', NULL, NULL, 'AZ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000554.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (862, NULL, 'John', 'McCain', 'AZ1', '1', 'Sen. John McCain', '(202) 224-2235', 'http://mccain.senate.gov/index.cfm?fuseaction=Contact.Home', NULL, 'AZ', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/M/M000303.jpg', 'http://mccain.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (863, NULL, 'Jon', 'Kyl', 'AZ2', '2', 'Sen. Jon Kyl', '(202) 224-4521', 'http://kyl.senate.gov/contact.cfm', NULL, 'AZ', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/K/K000352.jpg', 'http://kyl.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (864, NULL, 'Marion', 'Berry', 'AR01', '1', 'Rep. Marion Berry', '(202) 225-4076', 'http://www.house.gov/berry/zipauth.shtml', NULL, 'AR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000420.jpg', 'http://www.house.gov/berry/', 'D');
INSERT INTO `politicians` VALUES (865, NULL, 'Vic', 'Snyder', 'AR02', '2', 'Rep. Vic Snyder', '(202) 225-2506', 'snyder.congress@mail.house.gov', NULL, 'AR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000672.jpg', 'http://www.house.gov/snyder/', 'D');
INSERT INTO `politicians` VALUES (866, NULL, 'John', 'Boozman', 'AR03', '3', 'Rep. John Boozman', '(202) 225-4301', 'http://www.house.gov/writerep/', NULL, 'AR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001236.jpg', 'http://www.boozman.house.gov/', 'R');
INSERT INTO `politicians` VALUES (867, NULL, 'Mike', 'Ross', 'AR04', '4', 'Rep. Mike Ross', '(202) 225-3772', 'mike.ross@mail.house.gov', NULL, 'AR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000573.jpg', 'http://www.house.gov/ross/', 'D');
INSERT INTO `politicians` VALUES (868, NULL, 'Blanche', 'Lincoln', 'AR1', '1', 'Sen. Blanche Lincoln', '(202) 224-4843', 'http://lincoln.senate.gov/html/webform.html', NULL, 'AR', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/L/L000035.jpg', 'http://lincoln.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (869, NULL, 'Mark', 'Pryor', 'AR2', '2', 'Sen. Mark Pryor', '(202) 224-2353', 'senator@pryor.senate.gov', NULL, 'AR', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/P/P000590.jpg', 'http://pryor.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (870, NULL, 'Mike', 'Thompson', 'CA01', '1', 'Rep. Mike Thompson', '(202) 225-3311', 'http://mikethompson.house.gov/contact/email.asp', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000460.jpg', 'http://mikethompson.house.gov/', 'D');
INSERT INTO `politicians` VALUES (871, NULL, 'Wally', 'Herger', 'CA02', '2', 'Rep. Wally Herger', '(202) 225-3076', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000528.jpg', 'http://www.house.gov/herger/', 'R');
INSERT INTO `politicians` VALUES (872, NULL, 'Dan', 'Lungren', 'CA03', '3', 'Rep. Dan Lungren', '(202) 225-5716', 'http://www.house.gov/lungren/feedback.shtml', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000517.jpg', 'http://www.house.gov/lungren/', 'R');
INSERT INTO `politicians` VALUES (873, NULL, 'John', 'Doolittle', 'CA04', '4', 'Rep. John Doolittle', '(202) 225-2511', 'http://www.house.gov/doolittle/contact.html', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000429.jpg', 'http://www.house.gov/doolittle/', 'R');
INSERT INTO `politicians` VALUES (874, NULL, 'Doris', 'Matsui', 'CA05', '5', 'Rep. Doris Matsui', '(202) 225-7163', 'http://matsui.house.gov/email.asp', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001163.jpg', 'http://matsui.house.gov/', 'D');
INSERT INTO `politicians` VALUES (875, NULL, 'Lynn', 'Woolsey', 'CA06', '6', 'Rep. Lynn Woolsey', '(202) 225-5161', 'http://www.woolsey.house.gov/contactemailform.asp', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000738.jpg', 'http://www.woolsey.house.gov/', 'D');
INSERT INTO `politicians` VALUES (876, NULL, 'George', 'Miller', 'CA07', '7', 'Rep. George Miller', '(202) 225-2095', 'George.Miller@mail.house.gov', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001144.jpg', 'http://www.house.gov/georgemiller/', 'D');
INSERT INTO `politicians` VALUES (877, NULL, 'Nancy', 'Pelosi', 'CA08', '8', 'Rep. Nancy Pelosi', '(202) 225-4965', 'AmericanVoices@mail.house.gov', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000197.jpg', 'http://www.house.gov/pelosi/', 'D');
INSERT INTO `politicians` VALUES (878, NULL, 'Barbara', 'Lee', 'CA09', '9', 'Rep. Barbara Lee', '(202) 225-2661', ' barbara.lee@congressnewsletter.net', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000551.jpg', 'http://lee.house.gov/', 'D');
INSERT INTO `politicians` VALUES (879, NULL, 'Ellen', 'Tauscher', 'CA10', '10', 'Rep. Ellen Tauscher', '(202) 225-1880', 'http://www.house.gov/tauscher/IMA/get_address.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000057.jpg', 'http://www.house.gov/tauscher/', 'D');
INSERT INTO `politicians` VALUES (880, NULL, 'Jerry', 'McNerney', 'CA11', '11', 'Rep. Jerry McNerney', '(202) 225-1947', NULL, NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001166.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (881, NULL, 'Tom', 'Lantos', 'CA12', '12', 'Rep. Tom Lantos', '(202) 225-3531', 'http://lantos.house.gov/HoR/CA12/Contact+Tom/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000090.jpg', 'http://lantos.house.gov/', 'D');
INSERT INTO `politicians` VALUES (882, NULL, 'Pete', 'Stark', 'CA13', '13', 'Rep. Pete Stark', '(202) 225-5065', 'http://www.house.gov/stark/contact/index.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000810.jpg', 'http://www.house.gov/stark/', 'D');
INSERT INTO `politicians` VALUES (883, NULL, 'Anna', 'Eshoo', 'CA14', '14', 'Rep. Anna Eshoo', '(202) 225-8104', 'http://www-eshoo.house.gov/contact.aspx', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000215.jpg', 'http://www-eshoo.house.gov/', 'D');
INSERT INTO `politicians` VALUES (884, NULL, 'Mike', 'Honda', 'CA15', '15', 'Rep. Mike Honda', '(202) 225-2631', 'mike.honda@mail.house.gov', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001034.jpg', 'http://honda.house.gov/', 'D');
INSERT INTO `politicians` VALUES (885, NULL, 'Zoe', 'Lofgren', 'CA16', '16', 'Rep. Zoe Lofgren', '(202) 225-3072', NULL, NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000397.jpg', 'http://zoelofgren.house.gov/', 'D');
INSERT INTO `politicians` VALUES (886, NULL, 'Sam', 'Farr', 'CA17', '17', 'Rep. Sam Farr', '(202) 225-2861', 'http://www.farr.house.gov/feedback.cfm?campaign=farr&type=Contact%20Me', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000030.jpg', 'http://www.farr.house.gov/', 'D');
INSERT INTO `politicians` VALUES (887, NULL, 'Dennis', 'Cardoza', 'CA18', '18', 'Rep. Dennis Cardoza', '(202) 225-6131', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001050.jpg', 'http://www.house.gov/cardoza/', 'D');
INSERT INTO `politicians` VALUES (888, NULL, 'George', 'Radanovich', 'CA19', '19', 'Rep. George Radanovich', '(202) 225-4540', 'http://www.house.gov/radanovich/IMA/issue.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000004.jpg', 'http://www.radanovich.house.gov/', 'R');
INSERT INTO `politicians` VALUES (889, NULL, 'Jim', 'Costa', 'CA20', '20', 'Rep. Jim Costa', '(202) 225-3341', 'congressmanjimcosta@mail.house.gov', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001059.jpg', 'http://www.house.gov/costa/', 'D');
INSERT INTO `politicians` VALUES (890, NULL, 'Devin', 'Nunes', 'CA21', '21', 'Rep. Devin Nunes', '(202) 225-2523', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/N/N000181.jpg', 'http://www.house.gov/nunes/', 'R');
INSERT INTO `politicians` VALUES (891, NULL, 'Kevin', 'McCarthy', 'CA22', '22', 'Rep. Kevin McCarthy', '(202) 225-2915', NULL, NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001165.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (892, NULL, 'Lois', 'Capps', 'CA23', '23', 'Rep. Lois Capps', '(202) 225-3601', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001036.jpg', 'http://www.house.gov/capps/', 'D');
INSERT INTO `politicians` VALUES (893, NULL, 'Elton', 'Gallegly', 'CA24', '24', 'Rep. Elton Gallegly', '(202) 225-5811', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000021.jpg', 'http://www.house.gov/gallegly/', 'R');
INSERT INTO `politicians` VALUES (894, NULL, 'Buck', 'McKeon', 'CA25', '25', 'Rep. Buck McKeon', '(202) 225-1956', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000508.jpg', 'http://mckeon.house.gov/', 'R');
INSERT INTO `politicians` VALUES (895, NULL, 'David', 'Dreier', 'CA26', '26', 'Rep. David Dreier', '(202) 225-2305', 'http://dreier.house.gov/talkto.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000492.jpg', 'http://dreier.house.gov', 'R');
INSERT INTO `politicians` VALUES (896, NULL, 'Brad', 'Sherman', 'CA27', '27', 'Rep. Brad Sherman', '(202) 225-5911', 'http://www.house.gov/sherman/contact/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000344.jpg', 'http://www.house.gov/sherman/', 'D');
INSERT INTO `politicians` VALUES (897, NULL, 'Howard', 'Berman', 'CA28', '28', 'Rep. Howard Berman', '(202) 225-4695', 'http://www.house.gov/berman/contact/index.shtml', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000410.jpg', 'http://www.house.gov/berman/', 'D');
INSERT INTO `politicians` VALUES (898, NULL, 'Adam', 'Schiff', 'CA29', '29', 'Rep. Adam Schiff', '(202) 225-4176', 'http://schiff.house.gov/HoR/CA29/Contact+Information/Contact+Form.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001150.jpg', 'http://schiff.house.gov/', 'D');
INSERT INTO `politicians` VALUES (899, NULL, 'Henry', 'Waxman', 'CA30', '30', 'Rep. Henry Waxman', '(202) 225-3976', 'http://www.house.gov/waxman/contact.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000215.jpg', 'http://www.house.gov/waxman/', 'D');
INSERT INTO `politicians` VALUES (900, NULL, 'Xavier', 'Becerra', 'CA31', '31', 'Rep. Xavier Becerra', '(202) 225-6235', 'http://becerra.house.gov/HoR/CA31/Hidden+Content/Email+Signup+Form.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000287.jpg', 'http://becerra.house.gov/', 'D');
INSERT INTO `politicians` VALUES (901, NULL, 'Hilda', 'Solis', 'CA32', '32', 'Rep. Hilda Solis', '(202) 225-5464', 'http://solis.house.gov/Mail_Rep_Solis.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001153.jpg', 'http://solis.house.gov/', 'D');
INSERT INTO `politicians` VALUES (902, NULL, 'Diane', 'Watson', 'CA33', '33', 'Rep. Diane Watson', '(202) 225-7084', 'http://www.house.gov/watson/zipauth.shtml', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000794.jpg', 'http://www.house.gov/watson/', 'D');
INSERT INTO `politicians` VALUES (903, NULL, 'Lucille', 'Roybal-Allard', 'CA34', '34', 'Rep. Lucille Roybal-Allard', '(202) 225-1766', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000486.jpg', 'http://www.house.gov/roybal-allard/', 'D');
INSERT INTO `politicians` VALUES (904, NULL, 'Maxine', 'Waters', 'CA35', '35', 'Rep. Maxine Waters', '(202) 225-2201', 'http://www.house.gov/waters/IMA/issue.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000187.jpg', 'http://www.house.gov/waters/', 'D');
INSERT INTO `politicians` VALUES (905, NULL, 'Jane', 'Harman', 'CA36', '36', 'Rep. Jane Harman', '(202) 225-8220', NULL, NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000213.jpg', 'http://www.house.gov/harman/', 'D');
INSERT INTO `politicians` VALUES (906, NULL, 'Juanita', 'Millender-McDonald', 'CA37', '37', 'Rep. Juanita Millender-McDonald', '(202) 225-7924', 'millender.mcdonald@mail.house.gov', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000714.jpg', 'http://www.house.gov/millender-mcdonald/', 'D');
INSERT INTO `politicians` VALUES (907, NULL, 'Grace', 'Napolitano', 'CA38', '38', 'Rep. Grace Napolitano', '(202) 225-5256', 'http://www.house.gov/napolitano/feedback.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/N/N000179.jpg', 'http://www.house.gov/napolitano/', 'D');
INSERT INTO `politicians` VALUES (908, NULL, 'Linda', 'Sanchez', 'CA39', '39', 'Rep. Linda Sanchez', '(202) 225-6676', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000030.jpg', 'http://www.lindasanchez.house.gov/', 'D');
INSERT INTO `politicians` VALUES (909, NULL, 'Edward', 'Royce', 'CA40', '40', 'Rep. Ed Royce', '(202) 225-4111', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000487.jpg', 'http://www.royce.house.gov', 'R');
INSERT INTO `politicians` VALUES (910, NULL, 'Jerry', 'Lewis', 'CA41', '41', 'Rep. Jerry Lewis', '(202) 225-5861', 'http://www.house.gov/jerrylewis/IMA/WritetoRepresentativeLewis.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000293.jpg', 'http://www.house.gov/jerrylewis/', 'R');
INSERT INTO `politicians` VALUES (911, NULL, 'Gary', 'Miller', 'CA42', '42', 'Rep. Gary Miller', '(202) 225-3201', 'gary.miller@mail.house.gov', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001144.jpg', 'http://www.house.gov/garymiller/', 'R');
INSERT INTO `politicians` VALUES (912, NULL, 'Joe', 'Baca', 'CA43', '43', 'Rep. Joe Baca', '(202) 225-6161', 'http://www.house.gov/baca/zipauth.shtml', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001234.jpg', 'http://www.house.gov/baca/', 'D');
INSERT INTO `politicians` VALUES (913, NULL, 'Ken', 'Calvert', 'CA44', '44', 'Rep. Ken Calvert', '(202) 225-1986', 'http://calvert.house.gov/email.asp', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000059.jpg', 'http://calvert.house.gov/', 'R');
INSERT INTO `politicians` VALUES (914, NULL, 'Mary', 'Bono', 'CA45', '45', 'Rep. Mary Bono', '(202) 225-5330', 'http://www.house.gov/formbono/issue.htm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001228.jpg', 'http://www.house.gov/bono/', 'R');
INSERT INTO `politicians` VALUES (915, NULL, 'Dana', 'Rohrabacher', 'CA46', '46', 'Rep. Dana Rohrabacher', '(202) 225-2415', 'Dana@mail.house.gov', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000409.jpg', 'http://rohrabacher.house.gov/', 'R');
INSERT INTO `politicians` VALUES (916, NULL, 'Loretta', 'Sanchez', 'CA47', '47', 'Rep. Loretta Sanchez', '(202) 225-2965', 'http://www.lorettasanchez.house.gov/feedback.cfm?campaign=lorettasanchez&type=contact', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000030.jpg', 'http://www.lorettasanchez.house.gov/', 'D');
INSERT INTO `politicians` VALUES (917, NULL, 'John', 'Campbell', 'CA48', '48', 'Rep. John Campbell', '(202) 225-5611', 'http://campbell.house.gov/html/contact_FORM_EMAIL.cfm', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001064.jpg', 'http://www.house.gov/campbell/', 'R');
INSERT INTO `politicians` VALUES (918, NULL, 'Darrell', 'Issa', 'CA49', '49', 'Rep. Darrell Issa', '(202) 225-3906', 'http://issa.house.gov/index.cfm?FuseAction=ContactInformation.ContactForm&CFID=571116&CFTOKEN=14271113', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/I/I000056.jpg', 'http://issa.house.gov/', 'R');
INSERT INTO `politicians` VALUES (919, NULL, 'Brian', 'Bilbray', 'CA50', '50', 'Rep. Brian Bilbray', '(202) 225-5452', 'http://www.house.gov/bilbray/contact.shtml', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000461.jpg', 'http://www.house.gov/bilbray/', 'R');
INSERT INTO `politicians` VALUES (920, NULL, 'Bob', 'Filner', 'CA51', '51', 'Rep. Bob Filner', '(202) 225-8045', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000116.jpg', 'http://www.house.gov/filner/', 'D');
INSERT INTO `politicians` VALUES (921, NULL, 'Duncan', 'Hunter', 'CA52', '52', 'Rep. Duncan Hunter', '(202) 225-5672', 'http://www.house.gov/writerep/', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000981.jpg', 'http://www.house.gov/hunter/', 'R');
INSERT INTO `politicians` VALUES (922, NULL, 'Susan', 'Davis', 'CA53', '53', 'Rep. Susan Davis', '(202) 225-2040', 'http://www.house.gov/susandavis/IMA/contact.html', NULL, 'CA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000136.jpg', 'http://www.house.gov/susandavis/', 'D');
INSERT INTO `politicians` VALUES (923, NULL, 'Dianne', 'Feinstein', 'CA1', '1', 'Sen. Dianne Feinstein', '(202) 224-3841', 'http://feinstein.senate.gov/email.html', NULL, 'CA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/F/F000062.jpg', 'http://feinstein.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (924, NULL, 'Barbara', 'Boxer', 'CA2', '2', 'Sen. Barbara Boxer', '(202) 224-3553', 'http://boxer.senate.gov/contact/webform.cfm', NULL, 'CA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B000711.jpg', 'http://boxer.senate.gov', 'D');
INSERT INTO `politicians` VALUES (925, NULL, 'Diana', 'DeGette', 'CO01', '1', 'Rep. Diana DeGette', '(202) 225-4431', 'degette@mail.house.gov', NULL, 'CO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000197.jpg', 'http://www.house.gov/degette/', 'D');
INSERT INTO `politicians` VALUES (926, NULL, 'Mark', 'Udall', 'CO02', '2', 'Rep. Mark Udall', '(202) 225-2161', 'http://markudall.house.gov/HoR/CO02/Contact+Mark/Contact+Mark.htm', NULL, 'CO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/U/U000039.jpg', 'http://markudall.house.gov/', 'D');
INSERT INTO `politicians` VALUES (927, NULL, 'John', 'Salazar', 'CO03', '3', 'Rep. Tony Salazar', '(202) 225-4761', NULL, NULL, 'CO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001158.jpg', 'http://www.house.gov/salazar/', 'D');
INSERT INTO `politicians` VALUES (928, NULL, 'Marilyn', 'Musgrave', 'CO04', '4', 'Rep. Marilyn Musgrave', '(202) 225-4676', 'http://www.house.gov/writerep/', NULL, 'CO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001152.jpg', 'http://musgrave.house.gov/', 'R');
INSERT INTO `politicians` VALUES (929, NULL, 'Doug', 'Lamborn', 'CO05', '5', 'Rep. Doug Lamborn', '(202) 225-4422', NULL, NULL, 'CO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000564.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (930, NULL, 'Tom', 'Tancredo', 'CO06', '6', 'Rep. Tom Tancredo', '(202) 225-7882', 'tom.tancredo@mail.house.gov', NULL, 'CO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000458.jpg', 'http://www.tancredo.house.gov/', 'R');
INSERT INTO `politicians` VALUES (931, NULL, 'Ed', 'Perlmutter', 'CO07', '7', 'Rep. Ed Perlmutter', '(202) 225-2645', NULL, NULL, 'CO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000593.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (932, NULL, 'Wayne', 'Allard', 'CO1', '1', 'Sen. Wayne Allard', '(202) 224-5941', 'http://allard.senate.gov/contactme/index.cfm', NULL, 'CO', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/A/A000109.jpg', 'http://allard.senate.gov', 'R');
INSERT INTO `politicians` VALUES (933, NULL, 'Ken', 'Salazar', 'CO2', '2', 'Sen. Ken Salazar', '(202) 224-5852', 'http://salazar.senate.gov/contactus.cfm', NULL, 'CO', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S001163.jpg', 'http://salazar.senate.gov', 'D');
INSERT INTO `politicians` VALUES (934, NULL, 'John', 'Larson', 'CT01', '1', 'Rep. John Larson', '(202) 225-2265', 'http://www.house.gov/writerep/', NULL, 'CT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000557.jpg', 'http://www.house.gov/larson/', 'D');
INSERT INTO `politicians` VALUES (935, NULL, 'Joe', 'Courtney', 'CT02', '2', 'Rep. Joe Courtney', '(202) 225-2076', NULL, NULL, 'CT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001069.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (936, NULL, 'Rosa', 'DeLauro', 'CT03', '3', 'Rep. Rosa DeLauro', '(202) 225-3661', 'http://www.house.gov/delauro/message.html', NULL, 'CT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000216.jpg', 'http://www.house.gov/delauro/', 'D');
INSERT INTO `politicians` VALUES (937, NULL, 'Christopher', 'Shays', 'CT04', '4', 'Rep. Christopher Shays', '(202) 225-5541', 'rep.shays@mail.house.gov', NULL, 'CT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001144.jpg', 'http://www.house.gov/shays/', 'R');
INSERT INTO `politicians` VALUES (938, NULL, 'Christopher', 'Murphy', 'CT05', '5', 'Rep. Christopher Murphy', '(202) 225-4476', NULL, NULL, 'CT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001151.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (939, NULL, 'Christopher', 'Dodd', 'CT1', '1', 'Sen. Chris Dodd', '(202) 224-2823', 'http://dodd.senate.gov/webmail/form-opinion.html', NULL, 'CT', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/D/D000388.jpg', 'http://dodd.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (940, NULL, 'Joseph', 'Lieberman', 'CT2', '2', 'Sen. Joe Lieberman', '(202) 224-4041', 'http://lieberman.senate.gov/contact/index.cfm', NULL, 'CT', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/L/L000304.jpg', 'http://lieberman.senate.gov', 'D');
INSERT INTO `politicians` VALUES (941, NULL, 'Michael', 'Castle', 'DE01', 'one', 'Rep. Mike Castle', '(202) 225-4165', 'http://www.house.gov/writerep/', NULL, 'DE', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000243.jpg', 'http://www.house.gov/castle', 'R');
INSERT INTO `politicians` VALUES (942, NULL, 'Joseph', 'Biden', 'DE1', '1', 'Sen. Joe Biden', '(202) 224-5042', 'http://biden.senate.gov/contact/emailjoe.cfm', NULL, 'DE', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B000444.jpg', 'http://biden.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (943, NULL, 'Thomas', 'Carper', 'DE2', '2', 'Sen. Tom Carper', '(202) 224-2441', 'http://carper.senate.gov/aemail.htm', NULL, 'DE', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C000174.jpg', 'http://carper.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (944, NULL, 'Eleanor', 'Norton', 'DC01', '1', 'Del. Eleanor Norton', '(202) 225-8050', 'http://www.norton.house.gov/feedback.cfm?campaign=norton&type=Contact%20Me', NULL, 'DC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/N/N000147.jpg', 'http://www.norton.house.gov/', 'D');
INSERT INTO `politicians` VALUES (945, NULL, 'Jeff', 'Miller', 'FL01', '1', 'Rep. Jeff Miller', '(202) 225-4136', 'http://jeffmiller.house.gov/index.cfm?FuseAction=Contact.Home', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001144.jpg', 'http://jeffmiller.house.gov/', 'R');
INSERT INTO `politicians` VALUES (946, NULL, 'Allen', 'Boyd', 'FL02', '2', 'Rep. Allen Boyd', '(202) 225-5235', 'rep.boyd@mail.house.gov', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001258.jpg', 'http://www.house.gov/boyd/', 'D');
INSERT INTO `politicians` VALUES (947, NULL, 'Corrine', 'Brown', 'FL03', '3', 'Rep. Corrine Brown', '(202) 225-0123', 'http://www.house.gov/corrinebrown/IMA/issue.shtml', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001247.jpg', 'http://www.house.gov/corrinebrown/', 'D');
INSERT INTO `politicians` VALUES (948, NULL, 'Ander', 'Crenshaw', 'FL04', '4', 'Rep. Ander Crenshaw', '(202) 225-2501', 'http://crenshaw.house.gov/crenshaw-web/proc/?pa=customForm&sa=showEmailForm', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001045.jpg', 'http://crenshaw.house.gov/', 'R');
INSERT INTO `politicians` VALUES (949, NULL, 'Ginny', 'Brown-Waite', 'FL05', '5', 'Rep. Ginny Brown-Waite', '(202) 225-1002', 'http://www.house.gov/formbrown-waite/IMA/issue_subscribe.htm', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001247.jpg', 'http://brown-waite.house.gov/', 'R');
INSERT INTO `politicians` VALUES (950, NULL, 'Cliff', 'Stearns', 'FL06', '6', 'Rep. Cliff Stearns', '(202) 225-5744', NULL, NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000822.jpg', 'http://www.house.gov/stearns/', 'R');
INSERT INTO `politicians` VALUES (951, NULL, 'John', 'Mica', 'FL07', '7', 'Rep. John Mica', '(202) 225-4035', 'http://www.house.gov/mica/messageform.htm', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000689.jpg', 'http://www.house.gov/mica/', 'R');
INSERT INTO `politicians` VALUES (952, NULL, 'Ric', 'Keller', 'FL08', '8', 'Rep. Ric Keller', '(202) 225-2176', 'http://www.house.gov/writerep/', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000361.jpg', 'http://keller.house.gov/', 'R');
INSERT INTO `politicians` VALUES (953, NULL, 'Gus', 'Bilirakis', 'FL09', '9', 'Rep. Gus Bilirakis', '(202) 225-5755', NULL, NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001257.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (954, NULL, 'C.W.', 'Young', 'FL10', '10', 'Rep. Bill Young', '(202) 225-5961', 'bill.young@mail.house.gov', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/Y/Y000033.jpg', 'http://www.house.gov/young/', 'R');
INSERT INTO `politicians` VALUES (955, NULL, 'Kathy', 'Castor', 'FL11', '11', 'Rep. Kathy Castor', '(202) 225-3376', NULL, NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001066.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (956, NULL, 'Adam', 'Putnam', 'FL12', '12', 'Rep. Adam Putnam', '(202) 225-1252', 'http://www.adamputnam.house.gov/pages/contact.html', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000586.jpg', 'http://www.adamputnam.house.gov', 'R');
INSERT INTO `politicians` VALUES (957, NULL, 'Vern', 'Buchanan', 'FL13', '13', 'Rep. Vern Buchanan', '(202) 225-5015', NULL, NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001260.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (958, NULL, 'Connie', 'Mack', 'FL14', '14', 'Rep. Connie Mack', '(202) 225-2536', 'http://mack.house.gov/index.cfm?FuseAction=ContactConnie.ContactForm', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001155.jpg', 'http://mack.house.gov/', 'R');
INSERT INTO `politicians` VALUES (959, NULL, 'David', 'Weldon', 'FL15', '15', 'Rep. Dave Weldon', '(202) 225-3671', 'http://www.house.gov/writerep/', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000267.jpg', 'http://weldon.house.gov/', 'R');
INSERT INTO `politicians` VALUES (960, NULL, 'Tim', 'Mahoney', 'FL16', '16', 'Rep. Tim Mahoney', '(202) 225-5792', NULL, NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001164.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (961, NULL, 'Kendrick', 'Meek', 'FL17', '17', 'Rep. Kendrick Meek', '(202) 225-4506', 'http://kendrickmeek.house.gov/contact1.shtml', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001137.jpg', 'http://kendrickmeek.house.gov/', 'D');
INSERT INTO `politicians` VALUES (962, NULL, 'Ileana', 'Ros-Lehtinen', 'FL18', '18', 'Rep. Ileana Ros-Lehtinen', '(202) 225-3931', 'http://www.house.gov/ros-lehtinen/IMA/subscription.htm', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000435.jpg', 'http://www.house.gov/ros-lehtinen/', 'R');
INSERT INTO `politicians` VALUES (963, NULL, 'Robert', 'Wexler', 'FL19', '19', 'Rep. Bob Wexler', '(202) 225-3001', 'http://www.house.gov/writerep/', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000314.jpg', 'http://www.wexler.house.gov/', 'D');
INSERT INTO `politicians` VALUES (964, NULL, 'Debbie', 'Wasserman Schultz', 'FL20', '20', 'Rep. Debbie Wasserman Schultz', '(202) 225-7931', 'http://www.house.gov/schultz/zipauth.htm', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000797.jpg', 'http://www.house.gov/schultz/', 'D');
INSERT INTO `politicians` VALUES (965, NULL, 'Lincoln', 'Diaz-Balart', 'FL21', '21', 'Rep. Lincoln Diaz-Balart', '(202) 225-4211', 'http://diaz-balart.house.gov/index.cfm?FuseAction=Offices.Contact', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000600.jpg', 'http://diaz-balart.house.gov/', 'R');
INSERT INTO `politicians` VALUES (966, NULL, 'Ron', 'Klein', 'FL22', '22', 'Rep. Ron Klein', '(202) 225-3026', 'info@ronklein2006.com', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000366.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (967, NULL, 'Alcee', 'Hastings', 'FL23', '23', 'Rep. Alcee Hastings', '(202) 225-1313', 'http://alceehastings.house.gov/IMA/issue.htm', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000329.jpg', 'http://alceehastings.house.gov/', 'D');
INSERT INTO `politicians` VALUES (968, NULL, 'Tom', 'Feeney', 'FL24', '24', 'Rep. Tom Feeney', '(202) 225-2706', 'tom.feeney@mail.house.gov', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000447.jpg', 'http://www.house.gov/feeney/', 'R');
INSERT INTO `politicians` VALUES (969, NULL, 'Mario', 'Diaz-Balart', 'FL25', '25', 'Rep. Mario Diaz-Balart', '(202) 225-2778', 'http://www.house.gov/mariodiaz-balart/contact.htm', NULL, 'FL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000600.jpg', 'http://www.house.gov/mariodiaz-balart/', 'R');
INSERT INTO `politicians` VALUES (970, NULL, 'Bill', 'Nelson', 'FL1', '1', 'Sen. Bill Nelson', '(202) 224-5274', 'http://billnelson.senate.gov/contact/email.cfm', NULL, 'FL', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/N/N000180.jpg', 'http://billnelson.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (971, NULL, 'Mel', 'Martinez', 'FL2', '2', 'Sen. Mel Martinez', '(202) 224-3041', 'http://martinez.senate.gov/public/index.cfm?FuseAction=ContactInformation.ContactForm', NULL, 'FL', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/M/M001162.jpg', 'http://martinez.senate.gov/public/', 'R');
INSERT INTO `politicians` VALUES (972, NULL, 'Jack', 'Kingston', 'GA01', '1', 'Rep. Jack Kingston', '(202) 225-5831', 'jack.kingston@mail.house.gov', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000220.jpg', 'http://kingston.house.gov/', 'R');
INSERT INTO `politicians` VALUES (973, NULL, 'Sanford', 'Bishop', 'GA02', '2', 'Rep. Sanford Bishop', '(202) 225-3631', 'http://bishop.house.gov/display.cfm?content_id=229', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001242.jpg', 'http://bishop.house.gov/', 'D');
INSERT INTO `politicians` VALUES (974, NULL, 'Lynn', 'Westmoreland', 'GA03', '3', 'Rep. Lynn Westmoreland', '(202) 225-5901', 'http://www.house.gov/writerep/', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000796.jpg', 'http://www.house.gov/westmoreland/', 'R');
INSERT INTO `politicians` VALUES (975, NULL, 'Hank', 'Johnson', 'GA04', '4', 'Rep. Hank Johnson', '(202) 225-1605', NULL, NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000285.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (976, NULL, 'John', 'Lewis', 'GA05', '5', 'Rep. John Lewis', '(202) 225-3801', 'john.lewis@mail.house.gov', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000293.jpg', 'http://www.house.gov/johnlewis/', 'D');
INSERT INTO `politicians` VALUES (977, NULL, 'Tom', 'Price', 'GA06', '6', 'Rep. Tom Price', '(202) 225-4501', 'http://tom.house.gov/html/contact_form_email.cfm', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000591.jpg', 'http://tom.house.gov/', 'R');
INSERT INTO `politicians` VALUES (978, NULL, 'John', 'Linder', 'GA07', '7', 'Rep. John Linder', '(202) 225-4272', 'http://linder.house.gov/index.cfm?FuseAction=Contact.Home', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000321.jpg', 'http://linder.house.gov/', 'R');
INSERT INTO `politicians` VALUES (979, NULL, 'Jim', 'Marshall', 'GA08', '8', 'Rep. Jim Marshall', '(202) 225-6531', 'jim.marshall@mail.house.gov', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001146.jpg', 'http://www.house.gov/marshall/', 'D');
INSERT INTO `politicians` VALUES (980, NULL, 'Nathan', 'Deal', 'GA09', '9', 'Rep. Nathan Deal', '(202) 225-5211', 'http://www.house.gov/deal/contact/default.shtml', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000168.jpg', 'http://www.house.gov/deal/', 'R');
INSERT INTO `politicians` VALUES (981, NULL, 'Charlie', 'Norwood', 'GA10', '10', 'Rep. Charlie Norwood', '(202) 225-4101', 'rep.charlie.norwood@mail.house.gov', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/N/N000159.jpg', 'http://www.house.gov/norwood/', 'R');
INSERT INTO `politicians` VALUES (982, NULL, 'Phil', 'Gingrey', 'GA11', '11', 'Rep. Phil Gingrey', '(202) 225-2931', 'http://www.house.gov/formgingrey/IMA/issue.htm', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000550.jpg', 'http://gingrey.house.gov/', 'R');
INSERT INTO `politicians` VALUES (983, NULL, 'John', 'Barrow', 'GA12', '12', 'Rep. John Barrow', '(202) 225-2823', 'http://barrow.house.gov/contactemail.asp', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001252.jpg', 'http://barrow.house.gov/', 'D');
INSERT INTO `politicians` VALUES (984, NULL, 'David', 'Scott', 'GA13', '13', 'Rep. David Scott', '(202) 225-2939', 'http://www.house.gov/writerep/', NULL, 'GA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000185.jpg', 'http://www.davidscott.house.gov/', 'D');
INSERT INTO `politicians` VALUES (985, NULL, 'Saxby', 'Chambliss', 'GA1', '1', 'Sen. Saxby Chambliss', '(202) 224-3521', 'http://chambliss.senate.gov/Contact/default.cfm?pagemode=1', NULL, 'GA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C000286.jpg', 'http://chambliss.senate.gov', 'R');
INSERT INTO `politicians` VALUES (986, NULL, 'Johnny', 'Isakson', 'GA2', '2', 'Sen. Johnny Isakson', '(202) 224-3643', 'http://isakson.senate.gov/contact.html', NULL, 'GA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/I/I000055.jpg', 'http://isakson.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (987, NULL, 'Madeleine', 'Bordallo', 'GU01', '1', 'Del. Madeleine Bordallo', '(202) 225-1188', 'madeleine.bordallo@mail.house.gov', NULL, 'GU', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001245.jpg', 'http://www.house.gov/bordallo/', 'D');
INSERT INTO `politicians` VALUES (988, NULL, 'Neil', 'Abercrombie', 'HI01', '1', 'Rep. Neil Abercrombie', '(202) 225-2726', 'neil.abercrombie@mail.house.gov', NULL, 'HI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000014.jpg', 'http://www.house.gov/abercrombie', 'D');
INSERT INTO `politicians` VALUES (989, NULL, 'Mazie', 'Hirono', 'HI02', '2', 'Rep. Mazie Hirono', '(202) 225-4906', NULL, NULL, 'HI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001042.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (990, NULL, 'Daniel', 'Inouye', 'HI1', '1', 'Sen. Dan Inouye', '(202) 224-3934', 'http://inouye.senate.gov/abtform.html', NULL, 'HI', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/I/I000025.jpg', 'http://inouye.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (991, NULL, 'Daniel', 'Akaka', 'HI2', '2', 'Sen. Danny Akaka', '(202) 224-6361', 'senator@akaka.senate.gov', NULL, 'HI', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/A/A000069.jpg', 'http://akaka.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (992, NULL, 'Bill', 'Sali', 'ID01', '1', 'Rep. Bill Sali', '(202) 225-6611', NULL, NULL, 'ID', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001167.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (993, NULL, 'Mike', 'Simpson', 'ID02', '2', 'Rep. Mike Simpson', '(202) 225-5531', NULL, NULL, 'ID', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001148.jpg', 'http://www.house.gov/simpson/', 'R');
INSERT INTO `politicians` VALUES (994, NULL, 'Larry', 'Craig', 'ID1', '1', 'Sen. Larry Craig', '(202) 224-2752', 'http://craig.senate.gov/webform.html', NULL, 'ID', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C000858.jpg', 'http://craig.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (995, NULL, 'Michael', 'Crapo', 'ID2', '2', 'Sen. Mike Crapo', '(202) 224-6142', 'http://crapo.senate.gov/contact/email.cfm', NULL, 'ID', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C000880.jpg', 'http://crapo.senate.gov', 'R');
INSERT INTO `politicians` VALUES (996, NULL, 'Bobby', 'Rush', 'IL01', '1', 'Rep. Bobby Rush', '(202) 225-4372', 'http://www.house.gov/rush/zipauth.shtml', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000515.jpg', 'http://www.house.gov/rush/', 'D');
INSERT INTO `politicians` VALUES (997, NULL, 'Jesse', 'Jackson', 'IL02', '2', 'Rep. Jesse Jackson', '(202) 225-0773', 'http://www.house.gov/writerep/', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000032.jpg', 'http://www.house.gov/jackson/', 'D');
INSERT INTO `politicians` VALUES (998, NULL, 'Daniel', 'Lipinski', 'IL03', '3', 'Rep. Dan Lipinski', '(202) 225-5701', NULL, NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000563.jpg', 'http://www.house.gov/lipinski/', 'D');
INSERT INTO `politicians` VALUES (999, NULL, 'Luis', 'Gutierrez', 'IL04', '4', 'Rep. Luis Gutierrez', '(202) 225-8203', 'http://luisgutierrez.house.gov/feedback.cfm?campaign=luisgutierrez&type=Let%27s%20Talk', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000535.jpg', 'http://luisgutierrez.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1000, NULL, 'Rahm', 'Emanuel', 'IL05', '5', 'Rep. Rahm Emanuel', '(202) 225-4061', 'rahm.emanuel@mail.house.gov', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000287.jpg', 'http://www.house.gov/emanuel/', 'D');
INSERT INTO `politicians` VALUES (1001, NULL, 'Peter', 'Roskam', 'IL06', '6', 'Rep. Peter Roskam', '(202) 225-4561', NULL, NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000580.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (1002, NULL, 'Danny', 'Davis', 'IL07', '7', 'Rep. Danny Davis', '(202) 225-5006', 'http://www.house.gov/davis/zipauth.htm', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000136.jpg', 'http://www.house.gov/davis/', 'D');
INSERT INTO `politicians` VALUES (1003, NULL, 'Melissa', 'Bean', 'IL08', '8', 'Rep. Melissa Bean', '(202) 225-3711', 'http://www.house.gov/bean/IMA/issue_subscribe.htm', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001253.jpg', 'http://www.house.gov/bean/', 'D');
INSERT INTO `politicians` VALUES (1004, NULL, 'Janice', 'Schakowsky', 'IL09', '9', 'Rep. Jan Schakowsky', '(202) 225-2111', 'jan.schakowsky@mail.house.gov', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001145.jpg', 'http://www.house.gov/schakowsky/', 'D');
INSERT INTO `politicians` VALUES (1005, NULL, 'Mark', 'Kirk', 'IL10', '10', 'Rep. Mark Kirk', '(202) 225-4835', 'http://www.house.gov/kirk/zipauth.shtml', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000360.jpg', 'http://www.house.gov/kirk/', 'R');
INSERT INTO `politicians` VALUES (1006, NULL, 'Jerry', 'Weller', 'IL11', '11', 'Rep. Jerry Weller', '(202) 225-3635', 'http://www.house.gov/formweller/formweller/zipauth.htm', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000273.jpg', 'http://weller.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1007, NULL, 'Jerry', 'Costello', 'IL12', '12', 'Rep. Jerry Costello', '(202) 225-5661', 'http://www.house.gov/writerep/', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000794.jpg', 'http://www.house.gov/costello/', 'D');
INSERT INTO `politicians` VALUES (1008, NULL, 'Judy', 'Biggert', 'IL13', '13', 'Rep. Judy Biggert', '(202) 225-3515', 'http://judybiggert.house.gov/contact.asp', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001232.jpg', 'http://judybiggert.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1009, NULL, 'Dennis', 'Hastert', 'IL14', '14', 'Representative Dennis Hastert', '(202) 225-2976', 'listserv@ls1.house.gov', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000197.jpg', 'http://www.house.gov/hastert/', 'R');
INSERT INTO `politicians` VALUES (1010, NULL, 'Timothy', 'Johnson', 'IL15', '15', 'Rep. Tim Johnson', '(202) 225-2371', 'rep.johnson@mail.house.gov', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000285.jpg', 'http://www.house.gov/timjohnson/', 'R');
INSERT INTO `politicians` VALUES (1011, NULL, 'Donald', 'Manzullo', 'IL16', '16', 'Rep. Don Manzullo', '(202) 225-5676', 'http://www.house.gov/writerep/', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001138.jpg', 'http://manzullo.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1012, NULL, 'Philip', 'Hare', 'IL17', '17', 'Rep. Philip Hare', '(202) 225-5905', NULL, NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001040.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1013, NULL, 'Ray', 'LaHood', 'IL18', '18', 'Rep. Ray LaHood', '(202) 225-6201', 'http://www.house.gov/writerep/', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000552.jpg', 'http://www.house.gov/lahood/', 'R');
INSERT INTO `politicians` VALUES (1014, NULL, 'John', 'Shimkus', 'IL19', '19', 'Rep. John Shimkus', '(202) 225-5271', 'http://www.house.gov/shimkus/emailme.shtml', NULL, 'IL', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000364.jpg', 'http://www.house.gov/shimkus/', 'R');
INSERT INTO `politicians` VALUES (1015, NULL, 'Richard', 'Durbin', 'IL1', '1', 'Sen. Dick Durbin', '(202) 224-2152', 'http://durbin.senate.gov/contact.cfm', NULL, 'IL', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/D/D000563.jpg', 'http://durbin.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1016, NULL, 'Barack', 'Obama', 'IL2', '2', 'Sen. Barack Obama', '(202) 224-2854', 'http://obama.senate.gov/contact/', NULL, 'IL', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/O/O000167.jpg', 'http://obama.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1017, NULL, 'Peter', 'Visclosky', 'IN01', '1', 'Rep. Peter Visclosky', '(202) 225-2461', 'http://www.house.gov/writerep/', NULL, 'IN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/V/V000108.jpg', 'http://www.house.gov/visclosky/', 'D');
INSERT INTO `politicians` VALUES (1018, NULL, 'Joe', 'Donnelly', 'IN02', '2', 'Rep. Joe Donnelly', '(202) 225-3915', NULL, NULL, 'IN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000607.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1019, NULL, 'Mark', 'Souder', 'IN03', '3', 'Rep. Mark Souder', '(202) 225-4436', 'souder@mail.house.gov', NULL, 'IN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001143.jpg', 'http://souder.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1020, NULL, 'Steve', 'Buyer', 'IN04', '4', 'Rep. Steve Buyer', '(202) 225-5037', 'http://www.house.gov/writerep/', NULL, 'IN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001203.jpg', 'http://stevebuyer.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1021, NULL, 'Dan', 'Burton', 'IN05', '5', 'Rep. Dan Burton', '(202) 225-2276', 'http://www.house.gov/burton/zipauth.htm', NULL, 'IN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001149.jpg', 'http://www.house.gov/burton/', 'R');
INSERT INTO `politicians` VALUES (1022, NULL, 'Mike', 'Pence', 'IN06', '6', 'Rep. Mike Pence', '(202) 225-3021', 'mike.pence@mail.house.gov', NULL, 'IN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000587.jpg', 'http://mikepence.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1023, NULL, 'Julia', 'Carson', 'IN07', '7', 'Rep. Julia Carson', '(202) 225-4011', 'http://juliacarson.house.gov/contact.me.shtml', NULL, 'IN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000191.jpg', 'http://juliacarson.house.gov', 'D');
INSERT INTO `politicians` VALUES (1024, NULL, 'Brad', 'Ellsworth', 'IN08', '8', 'Rep. Brad Ellsworth', '(202) 225-4636', NULL, NULL, 'IN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000289.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1025, NULL, 'Baron', 'Hill', 'IN09', '9', 'Rep. Baron Hill', '(202) 225-5315', NULL, NULL, 'IN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001030.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1026, NULL, 'Richard', 'Lugar', 'IN1', '1', 'Sen. Dick Lugar', '(202) 224-4814', 'senator_lugar@lugar.senate.gov', NULL, 'IN', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/L/L000504.jpg', 'http://lugar.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1027, NULL, 'Evan', 'Bayh', 'IN2', '2', 'Sen. Evan Bayh', '(202) 224-5623', 'http://bayh.senate.gov/LegForm.htm', NULL, 'IN', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B001233.jpg', 'http://bayh.senate.gov', 'D');
INSERT INTO `politicians` VALUES (1028, NULL, 'Bruce', 'Braley', 'IA01', '1', 'Rep. Bruce Braley', '(202) 225-2911', NULL, NULL, 'IA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001259.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1029, NULL, 'David', 'Loebsack', 'IA02', '2', 'Rep. Dave Loebsack', '(202) 225-6576', NULL, NULL, 'IA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000565.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1030, NULL, 'Leonard', 'Boswell', 'IA03', '3', 'Rep. Leonard Boswell', '(202) 225-3806', 'rep.boswell.ia03@mail.house.gov', NULL, 'IA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000652.jpg', 'http://boswell.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1031, NULL, 'Tom', 'Latham', 'IA04', '4', 'Rep. Tom Latham', '(202) 225-5476', 'tom.latham@mail.house.gov', NULL, 'IA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000111.jpg', 'http://www.tomlatham.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1032, NULL, 'Steve', 'King', 'IA05', '5', 'Rep. Steve King', '(202) 225-4426', 'http://www.house.gov/writerep/', NULL, 'IA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000220.jpg', 'http://www.house.gov/steveking/', 'R');
INSERT INTO `politicians` VALUES (1033, NULL, 'Charles', 'Grassley', 'IA1', '1', 'Sen. Chuck Grassley', '(202) 224-3744', 'http://grassley.senate.gov/index.cfm?FuseAction=Contact.Home', NULL, 'IA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/G/G000386.jpg', 'http://grassley.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1034, NULL, 'Tom', 'Harkin', 'IA2', '2', 'Sen. Tom Harkin', '(202) 224-3254', 'http://harkin.senate.gov/contact/contact.cfm', NULL, 'IA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/H/H000206.jpg', 'http://harkin.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1035, NULL, 'Jerry', 'Moran', 'KS01', '1', 'Rep. Jerry Moran', '(202) 225-2715', 'http://www.house.gov/moranks01/hearingfromyou.htm', NULL, 'KS', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000934.jpg', 'http://www.house.gov/moranks01/', 'R');
INSERT INTO `politicians` VALUES (1036, NULL, 'Nancy', 'Boyda', 'KS02', '2', 'Rep. Nancy Boyda', '(202) 225-6601', NULL, NULL, 'KS', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001258.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1037, NULL, 'Dennis', 'Moore', 'KS03', '3', 'Rep. Dennis Moore', '(202) 225-2865', 'http://www.moore.house.gov/contact.htm', NULL, 'KS', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001160.jpg', 'http://www.moore.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1038, NULL, 'Todd', 'Tiahrt', 'KS04', '4', 'Rep. Todd Tiahrt', '(202) 225-6216', 'http://www.house.gov/tiahrt/e-mail_todd.htm', NULL, 'KS', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000260.jpg', 'http://www.house.gov/tiahrt/', 'R');
INSERT INTO `politicians` VALUES (1039, NULL, 'Sam', 'Brownback', 'KS1', '1', 'Sen. Sam Brownback', '(202) 224-6521', 'http://brownback.senate.gov/CMEmailMe.cfm', NULL, 'KS', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B000953.jpg', 'http://brownback.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1040, NULL, 'Pat', 'Roberts', 'KS2', '2', 'Sen. Pat Roberts', '(202) 224-4774', 'http://roberts.senate.gov/e-mail_pat.html', NULL, 'KS', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/R/R000307.jpg', 'http://roberts.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1041, NULL, 'Ed', 'Whitfield', 'KY01', '1', 'Rep. Ed Whitfield', '(202) 225-3115', 'http://whitfield.house.gov/ContactForm/', NULL, 'KY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000413.jpg', 'http://whitfield.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1042, NULL, 'Ron', 'Lewis', 'KY02', '2', 'Rep. Ron Lewis', '(202) 225-3501', 'ron.lewis@mail.house.gov', NULL, 'KY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000293.jpg', 'http://www.house.gov/ronlewis/', 'R');
INSERT INTO `politicians` VALUES (1043, NULL, 'John', 'Yarmuth', 'KY03', '3', 'Rep. John Yarmuth', '(202) 225-5401', NULL, NULL, 'KY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/Y/Y000062.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1044, NULL, 'Geoff', 'Davis', 'KY04', '4', 'Rep. Geoff Davis', '(202) 225-3465', 'http://geoffdavis.house.gov/Contact.aspx', NULL, 'KY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000136.jpg', 'http://geoffdavis.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1045, NULL, 'Harold', 'Rogers', 'KY05', '5', 'Rep. Hal Rogers', '(202) 225-4601', 'http://halrogers.house.gov/Contact.aspx', NULL, 'KY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000575.jpg', 'http://halrogers.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1046, NULL, 'Ben', 'Chandler', 'KY06', '6', 'Rep. Ben Chandler', '(202) 225-4706', 'ben.chandler@mail.house.gov', NULL, 'KY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001058.jpg', 'http://chandler.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1047, NULL, 'Mitch', 'McConnell', 'KY1', '1', 'Sen. Mitch McConnell', '(202) 224-2541', 'http://mcconnell.senate.gov/contact_form.cfm', NULL, 'KY', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/M/M000355.jpg', 'http://mcconnell.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1048, NULL, 'Jim', 'Bunning', 'KY2', '2', 'Sen. Jim Bunning', '(202) 224-4343', 'http://bunning.senate.gov/index.cfm?FuseAction=Contact.Email', NULL, 'KY', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B001066.jpg', 'http://bunning.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1049, NULL, 'Bobby', 'Jindal', 'LA01', '1', 'Rep. Bobby Jindal', '(202) 225-3015', 'bobby.jindal@mail.house.gov', NULL, 'LA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000287.jpg', 'http://jindal.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1050, NULL, 'William', 'Jefferson', 'LA02', '2', 'Rep. William Jefferson', '(202) 225-6636', NULL, NULL, 'LA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000070.jpg', 'http://www.house.gov/jefferson/', 'D');
INSERT INTO `politicians` VALUES (1051, NULL, 'Charlie', 'Melancon', 'LA03', '3', 'Rep. Charlie Melancon', '(202) 225-4031', 'http://www.melancon.house.gov/emailcharlie.asp', NULL, 'LA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001161.jpg', 'http://www.melancon.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1052, NULL, 'Jim', 'McCrery', 'LA04', '4', 'Rep. Jim McCrery', '(202) 225-2777', 'jim.mccrery@mail.house.gov', NULL, 'LA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000388.jpg', 'http://mccrery.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1053, NULL, 'Rodney', 'Alexander', 'LA05', '5', 'Rep. Rodney Alexander', '(202) 225-8490', 'http://www.house.gov/writerep/', NULL, 'LA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000361.jpg', 'http://www.house.gov/alexander/', 'R');
INSERT INTO `politicians` VALUES (1054, NULL, 'Richard', 'Baker', 'LA06', '6', 'Rep. Richard Baker', '(202) 225-3901', 'http://www.baker.house.gov/html/contact_form_email.cfm', NULL, 'LA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000072.jpg', 'http://www.baker.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1055, NULL, 'Charles', 'Boustany', 'LA07', '7', 'Rep. Charles Boustany', '(202) 225-2031', 'http://boustany.house.gov/ContactCharles.asp', NULL, 'LA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001255.jpg', 'http://boustany.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1056, NULL, 'Mary', 'Landrieu', 'LA1', '1', 'Sen. Mary Landrieu', '(202) 224-5824', 'http://landrieu.senate.gov/contact/index.cfm', NULL, 'LA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/L/L000550.jpg', 'http://landrieu.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1057, NULL, 'David', 'Vitter', 'LA2', '2', 'Sen. David Vitter', '(202) 224-4623', 'http://vitter.senate.gov/?module=webformiqv1', NULL, 'LA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/V/V000127.jpg', 'http://vitter.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1058, NULL, 'Thomas', 'Allen', 'ME01', '1', 'Rep. Tom Allen', '(202) 225-6116', 'http://tomallen.house.gov/article.asp?id=75', NULL, 'ME', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000357.jpg', 'http://tomallen.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1059, NULL, 'Michael', 'Michaud', 'ME02', '2', 'Rep. Michael Michaud', '(202) 225-6306', NULL, NULL, 'ME', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001149.jpg', 'http://michaud.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1060, NULL, 'Olympia', 'Snowe', 'ME1', '1', 'Sen. Olympia Snowe', '(202) 224-5344', 'http://snowe.senate.gov/Webform.htm', NULL, 'ME', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S000663.jpg', 'http://snowe.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1061, NULL, 'Susan', 'Collins', 'ME2', '2', 'Sen. Susan Collins', '(202) 224-2523', 'http://collins.senate.gov/public/continue.cfm?FuseAction=ContactSenatorCollins.Email&CFID=39113496&CFTOKEN=99427497', NULL, 'ME', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C001035.jpg', 'http://collins.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1062, NULL, 'Wayne', 'Gilchrest', 'MD01', '1', 'Rep. Wayne Gilchrest', '(202) 225-5311', 'http://gilchrest.house.gov/contact.asp?ContactType=Form', NULL, 'MD', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000180.jpg', 'http://gilchrest.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1063, NULL, 'C.A.', 'Ruppersberger', 'MD02', '2', 'Rep. Dutch Ruppersberger', '(202) 225-3061', 'http://www.dutch.house.gov/writedutch_za.shtml', NULL, 'MD', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000576.jpg', 'http://www.dutch.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1064, NULL, 'John', 'Sarbanes', 'MD03', '3', 'Rep. John Sarbanes', '(202) 225-4016', NULL, NULL, 'MD', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001168.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1065, NULL, 'Albert', 'Wynn', 'MD04', '4', 'Rep. Al Wynn', '(202) 225-8699', 'http://wynn.house.gov/feedback.cfm?campaign=wynn', NULL, 'MD', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000784.jpg', 'http://www.wynn.house.gov', 'D');
INSERT INTO `politicians` VALUES (1066, NULL, 'Steny', 'Hoyer', 'MD05', '5', 'Rep. Steny Hoyer', '(202) 225-4131', 'http://hoyer.house.gov/contact/email.asp', NULL, 'MD', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000874.jpg', 'http://hoyer.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1067, NULL, 'Roscoe', 'Bartlett', 'MD06', '6', 'Rep. Roscoe Bartlett', '(202) 225-2721', 'http://www.bartlett.house.gov/Email_Roscoe/', NULL, 'MD', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000208.jpg', 'http://www.bartlett.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1068, NULL, 'Elijah', 'Cummings', 'MD07', '7', 'Rep. Elijah Cummings', '(202) 225-4741', 'http://www.house.gov/writerep/', NULL, 'MD', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000984.jpg', 'http://www.house.gov/cummings/', 'D');
INSERT INTO `politicians` VALUES (1069, NULL, 'Chris', 'Van Hollen', 'MD08', '8', 'Rep. Chris Van Hollen', '(202) 225-5341', 'http://www.house.gov/writerep/', NULL, 'MD', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/V/V000128.jpg', 'http://www.house.gov/vanhollen/', 'D');
INSERT INTO `politicians` VALUES (1070, NULL, 'Barbara', 'Mikulski', 'MD1', '1', 'Sen. Barbara Mikulski', '(202) 224-4654', 'http://mikulski.senate.gov/mailform.html', NULL, 'MD', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/M/M000702.jpg', 'http://mikulski.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1071, NULL, 'Benjamin', 'Cardin', 'MD2', '2', 'Sen. Ben Cardin', '(202) 224-4524', NULL, NULL, 'MD', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C000141.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1072, NULL, 'John', 'Olver', 'MA01', '1', 'Rep. John Olver', '(202) 225-5335', 'http://www.house.gov/olver/contact/index.html', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/O/O000085.jpg', 'http://www.house.gov/olver/', 'D');
INSERT INTO `politicians` VALUES (1073, NULL, 'Richard', 'Neal', 'MA02', '2', 'Rep. Richie Neal', '(202) 225-5601', 'http://www.house.gov/writerep/', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/N/N000015.jpg', 'http://www.house.gov/neal/', 'D');
INSERT INTO `politicians` VALUES (1074, NULL, 'James', 'McGovern', 'MA03', '3', 'Rep. Jim McGovern', '(202) 225-6101', 'http://www.house.gov/writerep/', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000312.jpg', 'http://www.house.gov/mcgovern/', 'D');
INSERT INTO `politicians` VALUES (1075, NULL, 'Barney', 'Frank', 'MA04', '4', 'Rep. Barney Frank', '(202) 225-5931', 'http://www.house.gov/writerep/', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000448.jpg', 'http://www.house.gov/frank', 'D');
INSERT INTO `politicians` VALUES (1076, NULL, 'Martin', 'Meehan', 'MA05', '5', 'Rep. Marty Meehan', '(202) 225-3411', 'martin.meehan@mail.house.gov', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000627.jpg', 'http://www.house.gov/meehan/', 'D');
INSERT INTO `politicians` VALUES (1077, NULL, 'John', 'Tierney', 'MA06', '6', 'Rep. John Tierney', '(202) 225-8020', 'http://www.house.gov/tierney/IMA/email.shtml', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000266.jpg', 'http://www.house.gov/tierney/', 'D');
INSERT INTO `politicians` VALUES (1078, NULL, 'Edward', 'Markey', 'MA07', '7', 'Rep. Ed Markey', '(202) 225-2836', 'http://markey.house.gov/index.php?option=com_email_form&Itemid=124', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000133.jpg', 'http://markey.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1079, NULL, 'Michael', 'Capuano', 'MA08', '8', 'Rep. Michael Capuano', '(202) 225-5111', 'http://www.house.gov/capuano/contact/email.shtml', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001037.jpg', 'http://www.house.gov/capuano/', 'D');
INSERT INTO `politicians` VALUES (1080, NULL, 'Stephen', 'Lynch', 'MA09', '9', 'Rep. Steve Lynch', '(202) 225-8273', 'stephen.lynch@mail.house.gov', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000562.jpg', 'http://www.house.gov/lynch', 'D');
INSERT INTO `politicians` VALUES (1081, NULL, 'William', 'Delahunt', 'MA10', '10', 'Rep. Bill Delahunt', '(202) 225-3111', 'William.Delahunt@mail.house.gov', NULL, 'MA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000210.jpg', 'http://www.house.gov/delahunt/', 'D');
INSERT INTO `politicians` VALUES (1082, NULL, 'Edward', 'Kennedy', 'MA1', '1', 'Sen. Ted Kennedy', '(202) 224-4543', 'http://kennedy.senate.gov/contact.html', NULL, 'MA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/K/K000105.jpg', 'http://kennedy.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1083, NULL, 'John', 'Kerry', 'MA2', '2', 'Sen. John Kerry', '(202) 224-2742', 'http://kerry.senate.gov/v3/contact/email.cfm', NULL, 'MA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/K/K000148.jpg', 'http://kerry.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1084, NULL, 'Bart', 'Stupak', 'MI01', '1', 'Rep. Bart Stupak', '(202) 225-4735', 'http://www.house.gov/stupak/IMA/issue2.htm', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001045.jpg', 'http://www.house.gov/stupak/', 'D');
INSERT INTO `politicians` VALUES (1085, NULL, 'Peter', 'Hoekstra', 'MI02', '2', 'Rep. Pete Hoekstra', '(202) 225-4401', 'http://www.house.gov/formhoekstra/IMA/email.htm', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000676.jpg', 'http://hoekstra.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1086, NULL, 'Vernon', 'Ehlers', 'MI03', '3', 'Rep. Vern Ehlers', '(202) 225-3831', 'http://www.house.gov/writerep/', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000092.jpg', 'http://www.house.gov/ehlers/', 'R');
INSERT INTO `politicians` VALUES (1087, NULL, 'Dave', 'Camp', 'MI04', '4', 'Rep. Dave Camp', '(202) 225-3561', 'http://camp.house.gov/WriteRep.aspx', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001064.jpg', 'http://camp.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1088, NULL, 'Dale', 'Kildee', 'MI05', '5', 'Rep. Dale Kildee', '(202) 225-3611', 'http://www.house.gov/writerep/', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000172.jpg', 'http://www.house.gov/kildee/', 'D');
INSERT INTO `politicians` VALUES (1089, NULL, 'Fred', 'Upton', 'MI06', '6', 'Rep. Fred Upton', '(202) 225-3761', 'http://www.house.gov/writerep/', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/U/U000031.jpg', 'http://www.house.gov/upton/', 'R');
INSERT INTO `politicians` VALUES (1090, NULL, 'Tim', 'Walberg', 'MI07', '7', 'Rep. Tim Walberg', '(202) 225-6276', NULL, NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000798.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (1091, NULL, 'Mike', 'Rogers', 'MI08', '8', 'Rep. Mike Rogers', '(202) 225-4872', 'http://www.mikerogers.house.gov/Contact.aspx', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000575.jpg', 'http://www.mikerogers.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1092, NULL, 'Joe', 'Knollenberg', 'MI09', '9', 'Rep. Joe Knollenberg', '(202) 225-5802', NULL, NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000288.jpg', 'http://www.house.gov/knollenberg/', 'R');
INSERT INTO `politicians` VALUES (1093, NULL, 'Candice', 'Miller', 'MI10', '10', 'Rep. Candice Miller', '(202) 225-2106', 'http://www.house.gov/writerep/', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001144.jpg', 'http://candicemiller.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1094, NULL, 'Thaddeus', 'McCotter', 'MI11', '11', 'Rep. Thad McCotter', '(202) 225-8171', 'http://mccotter.house.gov/HoR/MI11/Contact/Office+Contact+Information/Zipcode+Authentication+Page.htm', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001147.jpg', 'http://mccotter.house.gov', 'R');
INSERT INTO `politicians` VALUES (1095, NULL, 'Sander', 'Levin', 'MI12', '12', 'Rep. Sandy Levin', '(202) 225-4961', 'http://www.house.gov/levin/zipauth.htm', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000263.jpg', 'http://www.house.gov/levin/', 'D');
INSERT INTO `politicians` VALUES (1096, NULL, 'Carolyn', 'Kilpatrick', 'MI13', '13', 'Rep. Carolyn Kilpatrick', '(202) 225-2261', 'http://www.house.gov/writerep/', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000180.jpg', 'http://www.house.gov/kilpatrick/', 'D');
INSERT INTO `politicians` VALUES (1097, NULL, 'John', 'Conyers', 'MI14', '14', 'Rep. John Conyers', '(202) 225-5126', 'John.Conyers@mail.house.gov', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000714.jpg', 'http://www.house.gov/conyers/', 'D');
INSERT INTO `politicians` VALUES (1098, NULL, 'John', 'Dingell', 'MI15', '15', 'Rep. John Dingell', '(202) 225-4071', 'http://www.house.gov/writerep/', NULL, 'MI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000355.jpg', 'http://www.house.gov/dingell/', 'D');
INSERT INTO `politicians` VALUES (1099, NULL, 'Carl', 'Levin', 'MI1', '1', 'Sen. Carl Levin', '(202) 224-6221', 'http://levin.senate.gov/contact/index.cfm', NULL, 'MI', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/L/L000261.jpg', 'http://levin.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1100, NULL, 'Debbie', 'Stabenow', 'MI2', '2', 'Sen. Debbie Stabenow', '(202) 224-4822', 'senator@stabenow.senate.gov', NULL, 'MI', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S000770.jpg', 'http://stabenow.senate.gov', 'D');
INSERT INTO `politicians` VALUES (1101, NULL, 'Tim', 'Walz', 'MN01', '1', 'Rep. Tim Walz', '(202) 225-2472', NULL, NULL, 'MN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000799.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1102, NULL, 'John', 'Kline', 'MN02', '2', 'Rep. John Kline', '(202) 225-2271', 'http://kline.house.gov/index.cfm?FuseAction=ContactInformation.ContactForm&To=mn02hwyr@housemail.house.gov&CFID=19955725&CFTOKEN=32424037', NULL, 'MN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000363.jpg', 'http://kline.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1103, NULL, 'Jim', 'Ramstad', 'MN03', '3', 'Rep. Jim Ramstad', '(202) 225-2871', 'MN03@mail.house.gov', NULL, 'MN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000033.jpg', 'http://www.house.gov/ramstad/', 'R');
INSERT INTO `politicians` VALUES (1104, NULL, 'Betty', 'McCollum', 'MN04', '4', 'Rep. Betty McCollum', '(202) 225-6631', 'http://www.mccollum.house.gov/index.asp?Type=NONE&SEC={AC61FD79-AD5F-440D-A7F0-555B12349E5B}', NULL, 'MN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001143.jpg', 'http://www.mccollum.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1105, NULL, 'Keith', 'Ellison', 'MN05', '5', 'Rep. Keith Ellison', '(202) 225-4755', NULL, NULL, 'MN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000288.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1106, NULL, 'Michele', 'Bachmann', 'MN06', '6', 'Rep. Michele Bachmann', '(202) 225-2331', NULL, NULL, 'MN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001256.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (1107, NULL, 'Collin', 'Peterson', 'MN07', '7', 'Rep. Collin Peterson', '(202) 225-2165', 'http://collinpeterson.house.gov/email.html', NULL, 'MN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000263.jpg', 'http://collinpeterson.house.gov//', 'D');
INSERT INTO `politicians` VALUES (1108, NULL, 'James', 'Oberstar', 'MN08', '8', 'Rep. Jim Oberstar', '(202) 225-6211', 'http://wwwc.house.gov/oberstar/zipauth.htm', NULL, 'MN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/O/O000006.jpg', 'http://www.oberstar.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1109, NULL, 'Norm', 'Coleman', 'MN1', '1', 'Sen. Norm Coleman', '(202) 224-5641', 'http://coleman.senate.gov/index.cfm?FuseAction=Contact.ContactForm', NULL, 'MN', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C001057.jpg', 'http://coleman.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1110, NULL, 'Amy', 'Klobuchar', 'MN2', '2', 'Sen. Amy Klobuchar', '(202) 224-3121', NULL, NULL, 'MN', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/K/K000367.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1111, NULL, 'Roger', 'Wicker', 'MS01', '1', 'Rep. Roger Wicker', '(202) 225-4306', 'roger.wicker@mail.house.gov', NULL, 'MS', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000437.jpg', 'http://www.house.gov/wicker/', 'R');
INSERT INTO `politicians` VALUES (1112, NULL, 'Bennie', 'Thompson', 'MS02', '2', 'Rep. Bennie Thompson', '(202) 225-5876', 'http://benniethompson.house.gov/HoR/MS02/Contact+Bennie/Contact+Bennie.htm', NULL, 'MS', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000460.jpg', 'http://www.benniethompson.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1113, NULL, 'Charles', 'Pickering', 'MS03', '3', 'Rep. Chip Pickering', '(202) 225-5031', 'http://www.house.gov/pickering/contact/', NULL, 'MS', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000323.jpg', 'http://www.house.gov/pickering/', 'R');
INSERT INTO `politicians` VALUES (1114, NULL, 'Gene', 'Taylor', 'MS04', '4', 'Rep. Gene Taylor', '(202) 225-5772', 'http://www.house.gov/genetaylor/zipauth.htm', NULL, 'MS', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000074.jpg', 'http://www.house.gov/genetaylor/', 'D');
INSERT INTO `politicians` VALUES (1115, NULL, 'Thad', 'Cochran', 'MS1', '1', 'Sen. Thad Cochran', '(202) 224-5054', 'http://cochran.senate.gov/contact.htm', NULL, 'MS', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C000372.jpg', 'http://cochran.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1116, NULL, 'Trent', 'Lott', 'MS2', '2', 'Sen. Trent Lott', '(202) 224-6253', 'http://lott.senate.gov/index.cfm?FuseAction=Contact.Email', NULL, 'MS', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/L/L000447.jpg', 'http://lott.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1117, NULL, 'William', 'Clay', 'MO01', '1', 'Rep. Lacy Clay', '(202) 225-2406', 'http://www.house.gov/clay/contact.htm', NULL, 'MO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001049.jpg', 'http://www.house.gov/clay/', 'D');
INSERT INTO `politicians` VALUES (1118, NULL, 'Todd', 'Akin', 'MO02', '2', 'Rep. Todd Akin', '(202) 225-2561', 'http://www.house.gov/akin/emailtodd.html', NULL, 'MO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000358.jpg', 'http://www.house.gov/akin/', 'R');
INSERT INTO `politicians` VALUES (1119, NULL, 'Russ', 'Carnahan', 'MO03', '3', 'Rep. Russ Carnahan', '(202) 225-2671', 'http://www.house.gov/carnahan/contact.shtml', NULL, 'MO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001060.jpg', 'http://www.house.gov/carnahan/', 'D');
INSERT INTO `politicians` VALUES (1120, NULL, 'Ike', 'Skelton', 'MO04', '4', 'Rep. Ike Skelton', '(202) 225-2876', 'http://www.house.gov/skelton/zipauth.htm', NULL, 'MO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000465.jpg', 'http://www.house.gov/skelton/', 'D');
INSERT INTO `politicians` VALUES (1121, NULL, 'Emanuel', 'Cleaver', 'MO05', '5', 'Rep. Emanuel Cleaver', '(202) 225-4535', 'http://www.house.gov/cleaver/IMA/issue.htm', NULL, 'MO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001061.jpg', 'http://www.house.gov/cleaver/', 'D');
INSERT INTO `politicians` VALUES (1122, NULL, 'Sam', 'Graves', 'MO06', '6', 'Rep. Sam Graves', '(202) 225-7041', 'sam.graves@mail.house.gov', NULL, 'MO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000546.jpg', 'http://www.house.gov/graves/', 'R');
INSERT INTO `politicians` VALUES (1123, NULL, 'Roy', 'Blunt', 'MO07', '7', 'Rep. Roy Blunt', '(202) 225-6536', 'http://www.blunt.house.gov/Contact.aspx', NULL, 'MO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000575.jpg', 'http://www.blunt.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1124, NULL, 'Jo Ann', 'Emerson', 'MO08', '8', 'Rep. Jo Ann Emerson', '(202) 225-4404', 'http://www.house.gov/emerson/contact/', NULL, 'MO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000172.jpg', 'http://www.house.gov/emerson/', 'R');
INSERT INTO `politicians` VALUES (1125, NULL, 'Kenny', 'Hulshof', 'MO09', '9', 'Rep. Kenny Hulshof', '(202) 225-2956', 'http://hulshof.house.gov/Contact.aspx', NULL, 'MO', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000948.jpg', 'http://hulshof.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1126, NULL, 'Kit', 'Bond', 'MO1', '1', 'Sen. Kit Bond', '(202) 224-5721', 'http://bond.senate.gov/contact/contactme.cfm', NULL, 'MO', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B000611.jpg', 'http://bond.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1127, NULL, 'Claire', 'McCaskill', 'MO2', '2', 'Sen. Claire McCaskill', '(202) 224-6154', NULL, NULL, 'MO', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/M/M001170.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1128, NULL, 'Dennis', 'Rehberg', 'MT01', 'one', 'Rep. Denny Rehberg', '(202) 225-3211', 'http://www.house.gov/writerep/', NULL, 'MT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000571.jpg', 'http://www.house.gov/rehberg/', 'R');
INSERT INTO `politicians` VALUES (1129, NULL, 'Max', 'Baucus', 'MT1', '1', 'Sen. Max Baucus', '(202) 224-2651', 'http://baucus.senate.gov/emailmax.html', NULL, 'MT', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B000243.jpg', 'http://baucus.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1130, NULL, 'Jon', 'Tester', 'MT2', '2', 'Sen. Jon Tester', '(202) 224-2644', NULL, NULL, 'MT', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/T/T000464.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1131, NULL, 'Jeff', 'Fortenberry', 'NE01', '1', 'Rep. Jeff Fortenberry', '(202) 225-4806', 'jeff.fortenberry@mail.house.gov', NULL, 'NE', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000449.jpg', 'http://fortenberry.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1132, NULL, 'Lee', 'Terry', 'NE02', '2', 'Rep. Lee Terry', '(202) 225-4155', 'talk2lee@mail.house.gov', NULL, 'NE', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000459.jpg', 'http://leeterry.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1133, NULL, 'Adrian', 'Smith', 'NE03', '3', 'Rep. Adrian Smith', '(202) 225-6435', NULL, NULL, 'NE', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000583.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (1134, NULL, 'Chuck', 'Hagel', 'NE1', '1', 'Sen. Chuck Hagel', '(202) 224-4224', 'http://hagel.senate.gov/index.cfm?FuseAction=Offices.Contact', NULL, 'NE', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/H/H001028.jpg', 'http://hagel.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1135, NULL, 'Ben', 'Nelson', 'NE2', '2', 'Sen. Ben Nelson', '(202) 224-6551', 'senator@bennelson.senate.gov', NULL, 'NE', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/N/N000180.jpg', 'http://bennelson.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1136, NULL, 'Shelley', 'Berkley', 'NV01', '1', 'Rep. Shelley Berkley', '(202) 225-5965', 'http://berkley.house.gov/contact/email.html', NULL, 'NV', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001231.jpg', 'http://berkley.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1137, NULL, 'Dean', 'Heller', 'NV02', '2', 'Rep. Dean Heller', '(202) 225-6155', NULL, NULL, 'NV', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001041.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (1138, NULL, 'Jon', 'Porter', 'NV03', '3', 'Rep. Jon Porter', '(202) 225-3252', 'http://www.house.gov/writerep/', NULL, 'NV', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000589.jpg', 'http://www.house.gov/porter/', 'R');
INSERT INTO `politicians` VALUES (1139, NULL, 'Harry', 'Reid', 'NV1', '1', 'Sen. Harry Reid', '(202) 224-3542', 'http://reid.senate.gov/email_form.cfm?lowsrc=1', NULL, 'NV', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/R/R000146.jpg', 'http://reid.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1140, NULL, 'John', 'Ensign', 'NV2', '2', 'Sen. John Ensign', '(202) 224-6244', 'http://ensign.senate.gov/forms/email_form.cfm', NULL, 'NV', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/E/E000194.jpg', 'http://ensign.senate.gov', 'R');
INSERT INTO `politicians` VALUES (1141, NULL, 'Carol', 'Shea-Porter', 'NH01', '1', 'Rep. Carol Shea-Porter', '(202) 225-5206', NULL, NULL, 'NH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001170.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1142, NULL, 'Paul', 'Hodes', 'NH02', '2', 'Rep. Paul Hodes', '(202) 225-5206', NULL, NULL, 'NH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001043.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1143, NULL, 'Judd', 'Gregg', 'NH1', '1', 'Sen. Judd Gregg', '(202) 224-3324', 'http://gregg.senate.gov/sitepages/contact.cfm', NULL, 'NH', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/G/G000445.jpg', 'http://gregg.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1144, NULL, 'John', 'Sununu', 'NH2', '2', 'Sen. John Sununu', '(202) 224-2841', 'http://www.sununu.senate.gov/webform.html', NULL, 'NH', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S001078.jpg', 'http://sununu.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1145, NULL, 'Robert', 'Andrews', 'NJ01', '1', 'Rep. Rob Andrews', '(202) 225-6501', 'http://www.house.gov/andrews/contact_form_za.shtml', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000210.jpg', 'http://www.house.gov/andrews/', 'D');
INSERT INTO `politicians` VALUES (1146, NULL, 'Frank', 'LoBiondo', 'NJ02', '2', 'Rep. Frank LoBiondo', '(202) 225-6572', 'http://www.house.gov/lobiondo/IMA/issue.htm', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000554.jpg', 'http://www.house.gov/lobiondo/', 'R');
INSERT INTO `politicians` VALUES (1147, NULL, 'Jim', 'Saxton', 'NJ03', '3', 'Rep. Jim Saxton', '(202) 225-4765', 'http://www.house.gov/writerep/', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000097.jpg', 'http://www.house.gov/saxton/', 'R');
INSERT INTO `politicians` VALUES (1148, NULL, 'Christopher', 'Smith', 'NJ04', '4', 'Rep. Chris Smith', '(202) 225-3765', 'http://www.house.gov/writerep/', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000583.jpg', 'http://www.house.gov/chrissmith/', 'R');
INSERT INTO `politicians` VALUES (1149, NULL, 'Scott', 'Garrett', 'NJ05', '5', 'Rep. Scott Garrett', '(202) 225-4465', 'http://www.house.gov/formgarrett/contact.shtml', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000548.jpg', 'http://garrett.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1150, NULL, 'Frank', 'Pallone', 'NJ06', '6', 'Rep. Frank Pallone', '(202) 225-4671', 'http://www.house.gov/writerep/', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000034.jpg', 'http://www.house.gov/pallone/', 'D');
INSERT INTO `politicians` VALUES (1151, NULL, 'Mike', 'Ferguson', 'NJ07', '7', 'Rep. Mike Ferguson', '(202) 225-5361', 'http://www.house.gov/ferguson/get_address2.shtml', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000443.jpg', 'http://www.house.gov/ferguson/', 'R');
INSERT INTO `politicians` VALUES (1152, NULL, 'William', 'Pascrell', 'NJ08', '8', 'Rep. Bill Pascrell', '(202) 225-5751', 'bill.pascrell@mail.house.gov', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000096.jpg', 'http://www.pascrell.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1153, NULL, 'Steven', 'Rothman', 'NJ09', '9', 'Rep. Steve Rothman', '(202) 225-5061', 'http://rothman.house.gov/contact_steve.htm', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000462.jpg', 'http://rothman.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1154, NULL, 'Donald', 'Payne', 'NJ10', '10', 'Rep. Donald Payne', '(202) 225-3436', 'http://www.house.gov/payne/IMA/issue.htm', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000149.jpg', 'http://www.house.gov/payne/', 'D');
INSERT INTO `politicians` VALUES (1155, NULL, 'Rodney', 'Frelinghuysen', 'NJ11', '11', 'Rep. Rodney Frelinghuysen', '(202) 225-5034', 'http://frelinghuysen.house.gov/IMA/zip_verify.htm', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000372.jpg', 'http://frelinghuysen.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1156, NULL, 'Rush', 'Holt', 'NJ12', '12', 'Rep. Rush Holt', '(202) 225-5801', 'http://holt.house.gov/feedback.cfm?campaign=holt&type=Contact%20Rush', NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001032.jpg', 'http://holt.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1157, NULL, 'Albio', 'Sires', 'NJ13', '13', 'Rep. Albio Sires', '(202) 225-7919', NULL, NULL, 'NJ', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001165.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1158, NULL, 'Frank', 'Lautenberg', 'NJ1', '1', 'Sen. Frank Lautenberg', '(202) 224-3224', 'http://lautenberg.senate.gov/webform.html', NULL, 'NJ', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/L/L000123.jpg', 'http://lautenberg.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1159, NULL, 'Robert', 'Menendez', 'NJ2', '2', 'Sen. Bob Menendez', '(202) 224-4744', 'http://menendez.senate.gov/contact/contact.cfm', NULL, 'NJ', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/M/M000639.jpg', 'http://menendez.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1160, NULL, 'Heather', 'Wilson', 'NM01', '1', 'Rep. Heather Wilson', '(202) 225-6316', 'http://wilson.house.gov/Contact.asp', NULL, 'NM', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000789.jpg', 'http://www.wilson.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1161, NULL, 'Stevan', 'Pearce', 'NM02', '2', 'Rep. Steve Pearce', '(202) 225-2365', 'http://www.house.gov/formpearce/email.htm', NULL, 'NM', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000588.jpg', 'http://pearce.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1162, NULL, 'Tom', 'Udall', 'NM03', '3', 'Rep. Tom Udall', '(202) 225-6190', 'http://www.tomudall.house.gov/feedback.cfm?campaign=Udall&type=Helping%20You%20', NULL, 'NM', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/U/U000039.jpg', 'http://www.tomudall.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1163, NULL, 'Pete', 'Domenici', 'NM1', '1', 'Sen. Pete Domenici', '(202) 224-6621', 'http://domenici.senate.gov/contact/contactform.cfm', NULL, 'NM', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/D/D000407.jpg', 'http://domenici.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1164, NULL, 'Jeff', 'Bingaman', 'NM2', '2', 'Sen. Jeff Bingaman', '(202) 224-5521', 'senator_bingaman@bingaman.senate.gov', NULL, 'NM', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B000468.jpg', 'http://bingaman.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1165, NULL, 'Timothy', 'Bishop', 'NY01', '1', 'Rep. Tim Bishop', '(202) 225-3826', 'http://wwwc.house.gov/timbishop/zipauth.htm', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001242.jpg', 'http://wwwc.house.gov/timbishop/', 'D');
INSERT INTO `politicians` VALUES (1166, NULL, 'Steve', 'Israel', 'NY02', '2', 'Rep. Steve Israel', '(202) 225-3335', 'http://www.house.gov/israel/contact/index.htm', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/I/I000057.jpg', 'http://www.house.gov/israel/', 'D');
INSERT INTO `politicians` VALUES (1167, NULL, 'Peter', 'King', 'NY03', '3', 'Rep. Pete King', '(202) 225-7896', 'pete.king@mail.house.gov', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000220.jpg', 'http://peteking.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1168, NULL, 'Carolyn', 'McCarthy', 'NY04', '4', 'Rep. Carolyn McCarthy', '(202) 225-5516', 'http://www.house.gov/writerep/', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001165.jpg', 'http://carolynmccarthy.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1169, NULL, 'Gary', 'Ackerman', 'NY05', '5', 'Rep. Gary Ackerman', '(202) 225-2601', 'http://www.house.gov/ackerman/pages/contact.html', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000022.jpg', 'http://www.house.gov/ackerman/', 'D');
INSERT INTO `politicians` VALUES (1170, NULL, 'Gregory', 'Meeks', 'NY06', '6', 'Rep. Gregory Meeks', '(202) 225-3461', 'http://www.house.gov/meeks/zipauth.htm', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001137.jpg', 'http://www.house.gov/meeks/', 'D');
INSERT INTO `politicians` VALUES (1171, NULL, 'Joseph', 'Crowley', 'NY07', '7', 'Rep. Joe Crowley', '(202) 225-3965', 'write2joecrowley@mail.house.gov', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001038.jpg', 'http://crowley.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1172, NULL, 'Jerrold', 'Nadler', 'NY08', '8', 'Rep. Jerry Nadler', '(202) 225-5635', 'http://www.house.gov/nadler/emailform.shtml', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/N/N000002.jpg', 'http://www.house.gov/nadler/', 'D');
INSERT INTO `politicians` VALUES (1173, NULL, 'Anthony', 'Weiner', 'NY09', '9', 'Rep. Anthony Weiner', '(202) 225-6616', 'weiner@mail.house.gov', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000792.jpg', 'http://www.house.gov/weiner/', 'D');
INSERT INTO `politicians` VALUES (1174, NULL, 'Edolphus', 'Towns', 'NY10', '10', 'Rep. Ed Towns', '(202) 225-5936', NULL, NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000326.jpg', 'http://www.house.gov/towns/', 'D');
INSERT INTO `politicians` VALUES (1175, NULL, 'Yvette', 'Clarke', 'NY11', '11', 'Rep. Yvette Clarke', '(202) 225-6231', NULL, NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001067.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1176, NULL, 'Nydia', 'Velazquez', 'NY12', '12', 'Rep. Nydia Velazquez', '(202) 225-2361', 'nydia.velazquez@mail.house.gov', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/V/V000081.jpg', 'http://www.house.gov/velazquez/', 'D');
INSERT INTO `politicians` VALUES (1177, NULL, 'Vito', 'Fossella', 'NY13', '13', 'Rep. Vito Fossella', '(202) 225-3371', 'vito.fossella@mail.house.gov', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000440.jpg', 'http://www.house.gov/fossella/', 'R');
INSERT INTO `politicians` VALUES (1178, NULL, 'Carolyn', 'Maloney', 'NY14', '14', 'Rep. Carolyn Maloney', '(202) 225-7944', 'Rep.Maloney@Housemail.house.gov', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000087.jpg', 'http://www.house.gov/maloney/', 'D');
INSERT INTO `politicians` VALUES (1179, NULL, 'Charles', 'Rangel', 'NY15', '15', 'Rep. Charlie Rangel', '(202) 225-4365', 'http://www.house.gov/writerep/', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000053.jpg', 'http://www.rangel.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1180, NULL, 'Jose''', 'Serrano', 'NY16', '16', 'Rep. Jose'' Serrano', '(202) 225-4361', 'jserrano@mail.house.gov', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000248.jpg', 'http://www.house.gov/serrano', 'D');
INSERT INTO `politicians` VALUES (1181, NULL, 'Eliot', 'Engel', 'NY17', '17', 'Rep. Eliot Engel', '(202) 225-2464', 'http://www.house.gov/writerep/', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000179.jpg', 'http://engel.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1182, NULL, 'Nita', 'Lowey', 'NY18', '18', 'Rep. Nita Lowey', '(202) 225-6506', 'http://www.house.gov/lowey/get_address.htm', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000480.jpg', 'http://www.house.gov/lowey/', 'D');
INSERT INTO `politicians` VALUES (1183, NULL, 'John', 'Hall', 'NY19', '19', 'Rep. John Hall', '(202) 225-5441', NULL, NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000067.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1184, NULL, 'Kirsten', 'Gillibrand', 'NY20', '20', 'Rep. Kirsten Gillibrand', '(202) 225-5614', NULL, NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000555.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1185, NULL, 'Michael', 'McNulty', 'NY21', '21', 'Rep. Mike McNulty', '(202) 225-5076', 'mike.mcnulty@mail.house.gov', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000590.jpg', 'http://www.house.gov/mcnulty/', 'D');
INSERT INTO `politicians` VALUES (1186, NULL, 'Maurice', 'Hinchey', 'NY22', '22', 'Rep. Maurice Hinchey', '(202) 225-6335', 'http://www.house.gov/hinchey/contact/', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000627.jpg', 'http://www.house.gov/hinchey/', 'D');
INSERT INTO `politicians` VALUES (1187, NULL, 'John', 'McHugh', 'NY23', '23', 'Rep. John McHugh', '(202) 225-4611', 'http://mchugh.house.gov/zipauth.htm', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000472.jpg', 'http://mchugh.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1188, NULL, 'Michael', 'Arcuri', 'NY24', '24', 'Rep. Michael Arcuri', '(202) 225-3665', NULL, NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000363.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1189, NULL, 'James', 'Walsh', 'NY25', '25', 'Rep. Jim Walsh', '(202) 225-3701', 'http://www.house.gov/writerep/', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000099.jpg', 'http://www.house.gov/walsh/', 'R');
INSERT INTO `politicians` VALUES (1190, NULL, 'Thomas', 'Reynolds', 'NY26', '26', 'Rep. Thomas Reynolds', '(202) 225-5265', 'http://www.house.gov/writerep/', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000569.jpg', 'http://www.house.gov/reynolds/', 'R');
INSERT INTO `politicians` VALUES (1191, NULL, 'Brian', 'Higgins', 'NY27', '27', 'Rep. Brian Higgins', '(202) 225-3306', 'http://higgins.house.gov/email.asp', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001038.jpg', 'http://www.house.gov/higgins/', 'D');
INSERT INTO `politicians` VALUES (1192, NULL, 'Louise', 'Slaughter', 'NY28', '28', 'Rep. Louise Slaughter', '(202) 225-3615', 'http://www.louise.house.gov/index.php?option=com_content&task=view&id=506&Itemid=150', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000480.jpg', 'http://www.louise.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1193, NULL, 'Randy', 'Kuhl', 'NY29', '29', 'Rep. Randy Kuhl', '(202) 225-3161', 'http://www.house.gov/formkuhl/IMA/issue.htm', NULL, 'NY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000364.jpg', 'http://kuhl.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1194, NULL, 'Charles', 'Schumer', 'NY1', '1', 'Sen. Chuck Schumer', '(202) 224-6542', 'http://schumer.senate.gov/SchumerWebsite/contact/webform.cfm', NULL, 'NY', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S000148.jpg', 'http://schumer.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1195, NULL, 'Hillary', 'Clinton', 'NY2', '2', 'Sen. Hillary Clinton', '(202) 224-4451', 'http://clinton.senate.gov/email_form.html', NULL, 'NY', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C001041.jpg', 'http://clinton.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1196, NULL, 'G.K.', 'Butterfield', 'NC01', '1', 'Rep. G.K. Butterfield', '(202) 225-3101', 'http://www.house.gov/butterfield/contact.shtml', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001251.jpg', 'http://www.house.gov/butterfield/', 'D');
INSERT INTO `politicians` VALUES (1197, NULL, 'Bob', 'Etheridge', 'NC02', '2', 'Rep. Bobby Etheridge', '(202) 225-4531', 'http://www.house.gov/etheridge/contactbob.htm', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000226.jpg', 'http://www.house.gov/etheridge/', 'D');
INSERT INTO `politicians` VALUES (1198, NULL, 'Walter', 'Jones', 'NC03', '3', 'Rep. Walter Jones', '(202) 225-3415', 'http://jones.house.gov/html/contact_form_email.cfm', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000255.jpg', 'http://jones.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1199, NULL, 'David', 'Price', 'NC04', '4', 'Rep. David Price', '(202) 225-1784', 'http://www.house.gov/formprice/email.htm', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000591.jpg', 'http://www.price.house.gov', 'D');
INSERT INTO `politicians` VALUES (1200, NULL, 'Virginia', 'Foxx', 'NC05', '5', 'Rep. Virginia Foxx', '(202) 225-2071', 'http://www.house.gov/formfoxx/IMA/issue_subscribe.htm', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000450.jpg', 'http://www.foxx.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1201, NULL, 'Howard', 'Coble', 'NC06', '6', 'Rep. Howard Coble', '(202) 225-3065', 'howard.coble@mail.house.gov', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000556.jpg', 'http://coble.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1202, NULL, 'Mike', 'McIntyre', 'NC07', '7', 'Rep. Mike McIntyre', '(202) 225-2731', 'http://www.house.gov/mcintyre/IMA/issue.htm', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000485.jpg', 'http://www.house.gov/mcintyre/', 'D');
INSERT INTO `politicians` VALUES (1203, NULL, 'Robin', 'Hayes', 'NC08', '8', 'Rep. Robin Hayes', '(202) 225-3715', 'http://www.house.gov/writerep/', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001029.jpg', 'http://www.hayes.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1204, NULL, 'Sue', 'Myrick', 'NC09', '9', 'Rep. Sue Myrick', '(202) 225-1976', 'myrick@mail.house.gov', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001134.jpg', 'http://myrick.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1205, NULL, 'Patrick', 'McHenry', 'NC10', '10', 'Rep. Pat McHenry', '(202) 225-2576', 'patrick.mchenry@mail.house.gov', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001156.jpg', 'http://mchenry.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1206, NULL, 'Heath', 'Shuler', 'NC11', '11', 'Rep. Heath Shuler', '(202) 225-6401', NULL, NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001171.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1207, NULL, 'Melvin', 'Watt', 'NC12', '12', 'Rep. Mel Watt', '(202) 225-1510', 'nc12.public@mail.house.gov', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000207.jpg', 'http://www.house.gov/watt/', 'D');
INSERT INTO `politicians` VALUES (1208, NULL, 'Brad', 'Miller', 'NC13', '13', 'Rep. Brad Miller', '(202) 225-3032', 'http://www.house.gov/writerep/', NULL, 'NC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001144.jpg', 'http://www.house.gov/bradmiller/', 'D');
INSERT INTO `politicians` VALUES (1209, NULL, 'Elizabeth', 'Dole', 'NC1', '1', 'Sen. Liddy Dole', '(202) 224-6342', 'http://dole.senate.gov/index.cfm?FuseAction=ContactInformation.ContactForm', NULL, 'NC', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/D/D000601.jpg', 'http://dole.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1210, NULL, 'Richard', 'Burr', 'NC2', '2', 'Sen. Richard Burr', '(202) 224-3154', 'http://burr.senate.gov/index.cfm?FuseAction=Contact.Home', NULL, 'NC', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B001135.jpg', 'http://burr.senate.gov', 'R');
INSERT INTO `politicians` VALUES (1211, NULL, 'Earl', 'Pomeroy', 'ND01', 'one', 'Rep. Earl Pomeroy', '(202) 225-2611', 'Rep.Earl.Pomeroy@mail.house.gov', NULL, 'ND', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000422.jpg', 'http://www.pomeroy.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1212, NULL, 'Kent', 'Conrad', 'ND1', '1', 'Sen. Kent Conrad', '(202) 224-2043', 'senator@conrad.senate.gov', NULL, 'ND', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C000705.jpg', 'http://conrad.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1213, NULL, 'Byron', 'Dorgan', 'ND2', '2', 'Sen. Byron Dorgan', '(202) 224-2551', 'senator@dorgan.senate.gov', NULL, 'ND', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/D/D000432.jpg', 'http://dorgan.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1214, NULL, 'Steve', 'Chabot', 'OH01', '1', 'Rep. Steve Chabot', '(202) 225-2216', 'http://www.house.gov/writerep/', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000266.jpg', 'http://www.house.gov/chabot/', 'R');
INSERT INTO `politicians` VALUES (1215, NULL, 'Jean', 'Schmidt', 'OH02', '2', 'Rep. Jean Schmidt', '(202) 225-3164', 'http://www.house.gov/schmidt/contact.shtml', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001164.jpg', 'http://www.house.gov/schmidt/', 'R');
INSERT INTO `politicians` VALUES (1216, NULL, 'Michael', 'Turner', 'OH03', '3', 'Rep. Michael Turner', '(202) 225-6465', 'oh03.wyr@mail.house.gov', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000463.jpg', 'http://www.house.gov/miketurner/', 'R');
INSERT INTO `politicians` VALUES (1217, NULL, 'Jim', 'Jordan', 'OH04', '4', 'Rep. Jim Jordan', '(202) 225-2676', NULL, NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000289.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (1218, NULL, 'Paul', 'Gillmor', 'OH05', '5', 'Rep. Paul Gillmor', '(202) 225-6405', 'http://www.house.gov/gillmor/mail/legmail1.htm', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000210.jpg', 'http://gillmor.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1219, NULL, 'Charlie', 'Wilson', 'OH06', '6', 'Rep. Charlie Wilson', '(202) 225-5705', NULL, NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000789.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1220, NULL, 'David', 'Hobson', 'OH07', '7', 'Rep. Dave Hobson', '(202) 225-4324', 'http://www.house.gov/hobson/formmail.htm', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000666.jpg', 'http://www.house.gov/hobson/', 'R');
INSERT INTO `politicians` VALUES (1221, NULL, 'John', 'Boehner', 'OH08', '8', 'Rep. John Boehner', '(202) 225-6205', 'http://johnboehner.house.gov/contact.asp', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000589.jpg', 'http://johnboehner.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1222, NULL, 'Marcy', 'Kaptur', 'OH09', '9', 'Rep. Marcy Kaptur', '(202) 225-4146', 'REP.KAPTUR@mail.house.gov', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000009.jpg', 'http://www.kaptur.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1223, NULL, 'Dennis', 'Kucinich', 'OH10', '10', 'Rep. Dennis Kucinich', '(202) 225-5871', 'http://www.house.gov/writerep/', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000336.jpg', 'http://kucinich.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1224, NULL, 'Stephanie', 'Jones', 'OH11', '11', 'Rep. Stephanie Jones', '(202) 225-7032', 'stephanie.tubbs.jones@mail.house.gov', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000255.jpg', 'http://www.house.gov/tubbsjones/', 'D');
INSERT INTO `politicians` VALUES (1225, NULL, 'Patrick', 'Tiberi', 'OH12', '12', 'Rep. Pat Tiberi', '(202) 225-5355', 'http://www.house.gov/writerep/', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000462.jpg', 'http://www.house.gov/tiberi/', 'R');
INSERT INTO `politicians` VALUES (1226, NULL, 'Betty', 'Sutton', 'OH13', '13', 'Rep. Betty Sutton', '(202) 225-3401', NULL, NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001174.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1227, NULL, 'Steven', 'LaTourette', 'OH14', '14', 'Rep. Steve LaTourette', '(202) 225-5731', 'http://www.house.gov/writerep/', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000553.jpg', 'http://www.house.gov/latourette/', 'R');
INSERT INTO `politicians` VALUES (1228, NULL, 'Deborah', 'Pryce', 'OH15', '15', 'Rep. Deborah Pryce', '(202) 225-2015', 'http://www.house.gov/pryce/IMA/write.htm', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000555.jpg', 'http://www.house.gov/pryce/', 'R');
INSERT INTO `politicians` VALUES (1229, NULL, 'Ralph', 'Regula', 'OH16', '16', 'Rep. Ralph Regula', '(202) 225-3876', 'http://www.house.gov/regula/zipauth.htm', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000141.jpg', 'http://wwwc.house.gov/regula/', 'R');
INSERT INTO `politicians` VALUES (1230, NULL, 'Timothy', 'Ryan', 'OH17', '17', 'Rep. Timothy Ryan', '(202) 225-5261', 'tim.ryan@mail.house.gov', NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000577.jpg', 'http://timryan.house.gov', 'D');
INSERT INTO `politicians` VALUES (1231, NULL, 'Zack', 'Space', 'OH18', '18', 'Rep. Zack Space', '(202) 225-6265', NULL, NULL, 'OH', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001173.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1232, NULL, 'George', 'Voinovich', 'OH1', '1', 'Sen. George Voinovich', '(202) 224-3353', 'http://voinovich.senate.gov/contact/index.htm', NULL, 'OH', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/V/V000126.jpg', 'http://voinovich.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1233, NULL, 'Sherrod', 'Brown', 'OH2', '2', 'Sen. Sherrod Brown', '(202) 224-2315', NULL, NULL, 'OH', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B000953.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1234, NULL, 'John', 'Sullivan', 'OK01', '1', 'Rep. John Sullivan', '(202) 225-2211', 'http://sullivan.house.gov/contact.shtml', NULL, 'OK', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001155.jpg', 'http://sullivan.house.gov', 'R');
INSERT INTO `politicians` VALUES (1235, NULL, 'Dan', 'Boren', 'OK02', '2', 'Rep. Dan Boren', '(202) 225-2701', 'dan.boren@mail.house.gov', NULL, 'OK', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001254.jpg', 'http://www.house.gov/boren/', 'D');
INSERT INTO `politicians` VALUES (1236, NULL, 'Frank', 'Lucas', 'OK03', '3', 'Rep. Frank Lucas', '(202) 225-5565', 'http://www.house.gov/lucas/zipauth.htm', NULL, 'OK', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000491.jpg', 'http://www.house.gov/lucas/', 'R');
INSERT INTO `politicians` VALUES (1237, NULL, 'Tom', 'Cole', 'OK04', '4', 'Rep. Tom Cole', '(202) 225-6165', 'http://www.house.gov/cole/contact.htm', NULL, 'OK', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001053.jpg', 'http://www.house.gov/cole/', 'R');
INSERT INTO `politicians` VALUES (1238, NULL, 'Mary', 'Fallin', 'OK05', '5', 'Rep. Mary Fallin', '(202) 225-2132', NULL, NULL, 'OK', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000453.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (1239, NULL, 'James', 'Inhofe', 'OK1', '1', 'Sen. Jim Inhofe', '(202) 224-4721', 'http://inhofe.senate.gov/contactus.htm', NULL, 'OK', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/I/I000024.jpg', 'http://inhofe.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1240, NULL, 'Tom', 'Coburn', 'OK2', '2', 'Sen. Tom Coburn', '(202) 224-5754', 'http://coburn.senate.gov/index.cfm?FuseAction=Contact.Home', NULL, 'OK', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C000560.jpg', 'http://www.coburn.senate.gov', 'R');
INSERT INTO `politicians` VALUES (1241, NULL, 'David', 'Wu', 'OR01', '1', 'Rep. David Wu', '(202) 225-0855', 'http://www.house.gov/writerep/', NULL, 'OR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000793.jpg', 'http://www.house.gov/wu/', 'D');
INSERT INTO `politicians` VALUES (1242, NULL, 'Greg', 'Walden', 'OR02', '2', 'Rep. Greg Walden', '(202) 225-6730', 'http://walden.house.gov/index.cfm?FuseAction=ContactGreg.ContactFormIQ', NULL, 'OR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000791.jpg', 'http://walden.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1243, NULL, 'Earl', 'Blumenauer', 'OR03', '3', 'Rep. Earl Blumenauer', '(202) 225-4811', 'http://blumenauer.house.gov/about/Contact.shtml', NULL, 'OR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000574.jpg', 'http://blumenauer.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1244, NULL, 'Peter', 'DeFazio', 'OR04', '4', 'Rep. Peter DeFazio', '(202) 225-6416', 'http://defazio.house.gov/emailme.shtml', NULL, 'OR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000191.jpg', 'http://www.defazio.house.gov', 'D');
INSERT INTO `politicians` VALUES (1245, NULL, 'Darlene', 'Hooley', 'OR05', '5', 'Rep. Darlene Hooley', '(202) 225-5711', 'http://hooley.house.gov/index.asp?Type=DYNAFORM&SEC={9BDA1E4D-2430-4E7D-B7AB-236B60C42F5A}', NULL, 'OR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000762.jpg', 'http://hooley.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1246, NULL, 'Ron', 'Wyden', 'OR1', '1', 'Sen. Ron Wyden', '(202) 224-5244', 'http://wyden.senate.gov/contact/', NULL, 'OR', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/W/W000779.jpg', 'http://wyden.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1247, NULL, 'Gordon', 'Smith', 'OR2', '2', 'Sen. Gordon Smith', '(202) 224-3753', 'http://gsmith.senate.gov/webform.htm', NULL, 'OR', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S001142.jpg', 'http://gsmith.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1248, NULL, 'Robert', 'Brady', 'PA01', '1', 'Rep. Bob Brady', '(202) 225-4731', 'http://www.house.gov/robertbrady/IMA/issue.htm', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001227.jpg', 'http://www.house.gov/robertbrady/', 'D');
INSERT INTO `politicians` VALUES (1249, NULL, 'Chaka', 'Fattah', 'PA02', '2', 'Rep. Chaka Fattah', '(202) 225-4001', 'http://www.house.gov/writerep/', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000043.jpg', 'http://www.house.gov/fattah/', 'D');
INSERT INTO `politicians` VALUES (1250, NULL, 'Phil', 'English', 'PA03', '3', 'Rep. Phil English', '(202) 225-5406', 'http://www.house.gov/english/zipauth.shtml', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000187.jpg', 'http://www.house.gov/english/', 'R');
INSERT INTO `politicians` VALUES (1251, NULL, 'Jason', 'Altmire', 'PA04', '4', 'Rep. Jason Altmire', '(202) 225-2565', NULL, NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/A/A000362.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1252, NULL, 'John', 'Peterson', 'PA05', '5', 'Rep. John Peterson', '(202) 225-5121', 'http://www.house.gov/johnpeterson/contact.htm', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000263.jpg', 'http://www.house.gov/johnpeterson/', 'R');
INSERT INTO `politicians` VALUES (1253, NULL, 'Jim', 'Gerlach', 'PA06', '6', 'Rep. Jim Gerlach', '(202) 225-4315', 'http://www.house.gov/writerep/', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000549.jpg', 'http://gerlach.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1254, NULL, 'Joe', 'Sestak', 'PA07', '7', 'Rep. Joe Sestak', '(202) 225-2011', NULL, NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001169.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1255, NULL, 'Patrick', 'Murphy', 'PA08', '8', 'Rep. Patrick Murphy', '(202) 225-4276', NULL, NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001151.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1256, NULL, 'Bill', 'Shuster', 'PA09', '9', 'Rep. Bill Shuster', '(202) 225-2431', 'http://www.house.gov/writerep/', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001154.jpg', 'http://www.house.gov/shuster/', 'R');
INSERT INTO `politicians` VALUES (1257, NULL, 'Chris', 'Carney', 'PA10', '10', 'Rep. Chris Carney', '(202) 225-3731', NULL, NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001065.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1258, NULL, 'Paul', 'Kanjorski', 'PA11', '11', 'Rep. Paul Kanjorski', '(202) 225-6511', 'paul.kanjorski@mail.house.gov', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000008.jpg', 'http://kanjorski.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1259, NULL, 'John', 'Murtha', 'PA12', '12', 'Rep. Jack Murtha', '(202) 225-2065', 'http://www.house.gov/murtha/write.shtml', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001120.jpg', 'http://www.house.gov/murtha/', 'D');
INSERT INTO `politicians` VALUES (1260, NULL, 'Allyson', 'Schwartz', 'PA13', '13', 'Rep. Allyson Schwartz', '(202) 225-6111', 'http://schwartz.house.gov/issue_subscribe.shtml', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S001162.jpg', 'http://schwartz.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1261, NULL, 'Michael', 'Doyle', 'PA14', '14', 'Rep. Mike Doyle', '(202) 225-2135', 'rep.doyle@mail.house.gov', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000482.jpg', 'http://www.house.gov/doyle/', 'D');
INSERT INTO `politicians` VALUES (1262, NULL, 'Charles', 'Dent', 'PA15', '15', 'Rep. Charlie Dent', '(202) 225-6411', 'http://dent.house.gov/verifyemail.shtml', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000604.jpg', 'http://dent.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1263, NULL, 'Joseph', 'Pitts', 'PA16', '16', 'Rep. Joe Pitts', '(202) 225-2411', 'pitts.pa16@mail.house.gov', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000373.jpg', 'http://www.house.gov/pitts/', 'R');
INSERT INTO `politicians` VALUES (1264, NULL, 'Tim', 'Holden', 'PA17', '17', 'Rep. Tim Holden', '(202) 225-5546', 'http://www.holden.house.gov/feedback-holden.cfm?campaign=Holden&type=Lets%20Talk&type=Lets%20Talk', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000712.jpg', 'http://www.holden.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1265, NULL, 'Timothy', 'Murphy', 'PA18', '18', 'Rep. Timothy Murphy', '(202) 225-2301', 'murphy@mail.house.gov', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001151.jpg', 'http://murphy.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1266, NULL, 'Todd', 'Platts', 'PA19', '19', 'Rep. Todd Platts', '(202) 225-5836', 'http://www.house.gov/platts/email.html', NULL, 'PA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000585.jpg', 'http://www.house.gov/platts/', 'R');
INSERT INTO `politicians` VALUES (1267, NULL, 'Arlen', 'Specter', 'PA1', '1', 'Sen. Arlen Specter', '(202) 224-4254', 'http://specter.senate.gov/index.cfm?FuseAction=ContactInfo.Home', NULL, 'PA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S000709.jpg', 'http://specter.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1268, NULL, 'Bob', 'Casey', 'PA2', '2', 'Sen. Bob Casey', '(202) 224-6324', NULL, NULL, 'PA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C001070.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1269, NULL, 'Luis', 'Fortuno', 'PR01', '1', 'Rep. Luis Fortuno', '(202) 225-2615', 'luis.fortuno@mail.house.gov', NULL, 'PR', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F012327.jpg', 'http://www.house.gov/fortuno/', 'R');
INSERT INTO `politicians` VALUES (1270, NULL, 'Patrick', 'Kennedy', 'RI01', '1', 'Rep. Patrick Kennedy', '(202) 225-4911', 'patrick.kennedy@mail.house.gov', NULL, 'RI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000113.jpg', 'http://www.patrickkennedy.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1271, NULL, 'James', 'Langevin', 'RI02', '2', 'Rep. Jim Langevin', '(202) 225-2735', 'http://www.house.gov/langevin/comments.html', NULL, 'RI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000559.jpg', 'http://www.house.gov/langevin/', 'D');
INSERT INTO `politicians` VALUES (1272, NULL, 'Jack', 'Reed', 'RI1', '1', 'Sen. Jack Reed', '(202) 224-4642', 'http://reed.senate.gov/contact/thoughts.cfm', NULL, 'RI', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/R/R000122.jpg', 'http://reed.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1273, NULL, 'Sheldon', 'Whitehouse', 'RI2', '2', 'Sen. Sheldon Whitehouse', '(202) 224-2921', NULL, NULL, 'RI', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/W/W000802.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1274, NULL, 'Henry', 'Brown', 'SC01', '1', 'Rep. Henry Brown', '(202) 225-3176', 'writehenrybrown@mail.house.gov', NULL, 'SC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001247.jpg', 'http://brown.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1275, NULL, 'Joe', 'Wilson', 'SC02', '2', 'Rep. Joe Wilson', '(202) 225-2452', 'http://www.house.gov/formwilson/IMA/issue.htm', NULL, 'SC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000789.jpg', 'http://joewilson.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1276, NULL, 'J. Gresham', 'Barrett', 'SC03', '3', 'Rep. Gresham Barrett', '(202) 225-5301', 'http://www.house.gov/barrett/writebarrett.shtml', NULL, 'SC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001239.jpg', 'http://www.house.gov/barrett/', 'R');
INSERT INTO `politicians` VALUES (1277, NULL, 'Bob', 'Inglis', 'SC04', '4', 'Rep. Bob Inglis', '(202) 225-6030', 'http://inglis.house.gov/contact.asp?content=sections/contact/write_inglis', NULL, 'SC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/I/I000023.jpg', 'http://inglis.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1278, NULL, 'John', 'Spratt', 'SC05', '5', 'Rep. John Spratt', '(202) 225-5501', 'http://www.house.gov/spratt/email_john.shtml', NULL, 'SC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000749.jpg', 'http://www.house.gov/spratt/', 'D');
INSERT INTO `politicians` VALUES (1279, NULL, 'James', 'Clyburn', 'SC06', '6', 'Rep. Jim Clyburn', '(202) 225-3315', 'jclyburn@mail.house.gov', NULL, 'SC', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000537.jpg', 'http://clyburn.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1280, NULL, 'Lindsey', 'Graham', 'SC1', '1', 'Sen. Lindsey Graham', '(202) 224-5972', 'http://lgraham.senate.gov/index.cfm?mode=contactform', NULL, 'SC', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/G/G000359.jpg', 'http://lgraham.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1281, NULL, 'Jim', 'DeMint', 'SC2', '2', 'Sen. Jim DeMint', '(202) 224-6121', 'http://demint.senate.gov/index.cfm?FuseAction=Contact.Home', NULL, 'SC', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/D/D000595.jpg', 'http://demint.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1282, NULL, 'Stephanie', 'Herseth', 'SD01', 'one', 'Rep. Stephanie Herseth', '(202) 225-2801', 'stephanie.herseth@mail.house.gov', NULL, 'SD', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001037.jpg', 'http://www.house.gov/herseth/', 'D');
INSERT INTO `politicians` VALUES (1283, NULL, 'Tim', 'Johnson', 'SD1', '1', 'Sen. Tim Johnson', '(202) 224-5842', 'http://johnson.senate.gov/emailform.html', NULL, 'SD', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/J/J000177.jpg', 'http://johnson.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1284, NULL, 'John', 'Thune', 'SD2', '2', 'Sen. John Thune', '(202) 224-2321', 'http://www.thune.senate.gov/index.cfm?FuseAction=Contact.Home', NULL, 'SD', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/T/T000250.jpg', 'http://thune.senate.gov/public/', 'R');
INSERT INTO `politicians` VALUES (1285, NULL, 'David', 'Davis', 'TN01', '1', 'Rep. David Davis', '(202) 225-6356', NULL, NULL, 'TN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000136.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (1286, NULL, 'John', 'Duncan', 'TN02', '2', 'Rep. Jimmy Duncan', '(202) 225-5435', 'http://www.house.gov/writerep/', NULL, 'TN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000533.jpg', 'http://www.house.gov/duncan/', 'R');
INSERT INTO `politicians` VALUES (1287, NULL, 'Zach', 'Wamp', 'TN03', '3', 'Rep. Zach Wamp', '(202) 225-3271', 'http://www.house.gov/wamp/IMA/get_address4.htm', NULL, 'TN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000119.jpg', 'http://www.house.gov/wamp/', 'R');
INSERT INTO `politicians` VALUES (1288, NULL, 'Lincoln', 'Davis', 'TN04', '4', 'Rep. Lincoln Davis', '(202) 225-6831', 'http://www.house.gov/writerep/', NULL, 'TN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000136.jpg', 'http://www.house.gov/lincolndavis/', 'D');
INSERT INTO `politicians` VALUES (1289, NULL, 'Jim', 'Cooper', 'TN05', '5', 'Rep. Jim Cooper', '(202) 225-4311', 'http://cooper.house.gov/email.htm', NULL, 'TN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000754.jpg', 'http://www.cooper.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1290, NULL, 'Bart', 'Gordon', 'TN06', '6', 'Rep. Bart Gordon', '(202) 225-4231', 'http://www.house.gov/gordon/contact/index.shtml', NULL, 'TN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000309.jpg', 'http://www.house.gov/gordon/', 'D');
INSERT INTO `politicians` VALUES (1291, NULL, 'Marsha', 'Blackburn', 'TN07', '7', 'Rep. Marsha Blackburn', '(202) 225-2811', 'http://www.house.gov/writerep/', NULL, 'TN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001243.jpg', 'http://www.house.gov/blackburn/', 'R');
INSERT INTO `politicians` VALUES (1292, NULL, 'John', 'Tanner', 'TN08', '8', 'Rep. John Tanner', '(202) 225-4714', 'http://www.house.gov/writerep/', NULL, 'TN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000038.jpg', 'http://www.house.gov/tanner/', 'D');
INSERT INTO `politicians` VALUES (1293, NULL, 'Stephen', 'Cohen', 'TN09', '9', 'Rep. Steve Cohen', '(202) 225-3265', NULL, NULL, 'TN', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001068.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1294, NULL, 'Lamar', 'Alexander', 'TN1', '1', 'Sen. Lamar Alexander', '(202) 224-4944', 'http://alexander.senate.gov/index.cfm?FuseAction=Contact.Home', NULL, 'TN', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/A/A000360.jpg', 'http://alexander.senate.gov', 'R');
INSERT INTO `politicians` VALUES (1295, NULL, 'Bob', 'Corker', 'TN2', '2', 'Sen. Bill Corker', '(202) 224-3344', NULL, NULL, 'TN', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C001071.jpg', NULL, 'R');
INSERT INTO `politicians` VALUES (1296, NULL, 'Louis', 'Gohmert', 'TX01', '1', 'Rep. Louie Gohmert', '(202) 225-3035', 'http://gohmert.house.gov/contact_louie.htm', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000552.jpg', 'http://gohmert.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1297, NULL, 'Ted', 'Poe', 'TX02', '2', 'Rep. Ted Poe', '(202) 225-6565', 'http://www.house.gov/poe/writeyourrep.htm', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000592.jpg', 'http://www.house.gov/poe/', 'R');
INSERT INTO `politicians` VALUES (1298, NULL, 'Sam', 'Johnson', 'TX03', '3', 'Rep. Sam Johnson', '(202) 225-4201', 'http://www.house.gov/formsamjohnson/IMA/issue.htm', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000285.jpg', 'http://samjohnson.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1299, NULL, 'Ralph', 'Hall', 'TX04', '4', 'Rep. Ralph Hall', '(202) 225-6673', 'http://www.house.gov/ralphhall/IMA/zipauth.htm', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000067.jpg', 'http://www.house.gov/ralphhall/', 'R');
INSERT INTO `politicians` VALUES (1300, NULL, 'Jeb', 'Hensarling', 'TX05', '5', 'Rep. Jeb Hensarling', '(202) 225-3484', 'http://www.house.gov/hensarling/contact/zipauth.htm', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H001036.jpg', 'http://www.house.gov/hensarling/', 'R');
INSERT INTO `politicians` VALUES (1301, NULL, 'Joe', 'Barton', 'TX06', '6', 'Rep. Joe Barton', '(202) 225-2002', 'http://joebarton.house.gov/contact.asp', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000213.jpg', 'http://joebarton.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1302, NULL, 'John', 'Culberson', 'TX07', '7', 'Rep. John Culberson', '(202) 225-2571', 'http://culberson.house.gov/contactinfo.aspx', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001048.jpg', 'http://culberson.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1303, NULL, 'Kevin', 'Brady', 'TX08', '8', 'Rep. Kevin Brady', '(202) 225-4901', 'rep.brady@mail.house.gov', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001227.jpg', 'http://www.house.gov/brady/', 'R');
INSERT INTO `politicians` VALUES (1304, NULL, 'Al', 'Green', 'TX09', '9', 'Rep. Al Green', '(202) 225-7508', 'http://www.house.gov/writerep/', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000410.jpg', 'http://www.house.gov/algreen/', 'D');
INSERT INTO `politicians` VALUES (1305, NULL, 'Michael', 'McCaul', 'TX10', '10', 'Rep. Michael McCaul', '(202) 225-2401', 'http://www.house.gov/writerep/', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001157.jpg', 'http://www.house.gov/mccaul/', 'R');
INSERT INTO `politicians` VALUES (1306, NULL, 'Mike', 'Conaway', 'TX11', '11', 'Rep. Mike Conaway', '(202) 225-3605', 'http://conaway.house.gov/IMA/contact.asp', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001062.jpg', 'http://conaway.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1307, NULL, 'Kay', 'Granger', 'TX12', '12', 'Rep. Kay Granger', '(202) 225-5071', 'texas.granger@mail.house.gov', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000377.jpg', 'http://kaygranger.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1308, NULL, 'Mac', 'Thornberry', 'TX13', '13', 'Rep. Mac Thornberry', '(202) 225-3706', 'http://www.house.gov/writerep/', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/T/T000238.jpg', 'http://www.house.gov/thornberry/', 'R');
INSERT INTO `politicians` VALUES (1309, NULL, 'Ron', 'Paul', 'TX14', '14', 'Rep. Ron Paul', '(202) 225-2831', 'http://www.house.gov/paul/mail/welcome.htm', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000583.jpg', 'http://www.house.gov/paul/', 'R');
INSERT INTO `politicians` VALUES (1310, NULL, 'Ruben', 'Hinojosa', 'TX15', '15', 'Rep. Ruben Hinojosa', '(202) 225-2531', 'http://www.house.gov/writerep/', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000636.jpg', 'http://hinojosa.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1311, NULL, 'Silvestre', 'Reyes', 'TX16', '16', 'Rep. Silvestre Reyes', '(202) 225-4831', 'http://wwwc.house.gov/reyes/voice_your_opinion.asp', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000170.jpg', 'http://wwwc.house.gov/reyes/', 'D');
INSERT INTO `politicians` VALUES (1312, NULL, 'Chet', 'Edwards', 'TX17', '17', 'Rep. Chet Edwards', '(202) 225-6105', 'http://edwards.house.gov/html/contact_form_email.cfm', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/E/E000063.jpg', 'http://edwards.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1313, NULL, 'Sheila', 'Jackson Lee', 'TX18', '18', 'Rep. Sheila Jackson Lee', '(202) 225-3816', 'http://www.jacksonlee.house.gov/feedback.cfm?campaign=jacksonlee&type=Let%27s%20Talk', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000294.jpg', 'http://www.jacksonlee.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1314, NULL, 'Randy', 'Neugebauer', 'TX19', '19', 'Rep. Randy Neugebauer', '(202) 225-4005', 'http://www.randy.house.gov/contact/', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/N/N000182.jpg', 'http://www.randy.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1315, NULL, 'Charles', 'Gonzalez', 'TX20', '20', 'Rep. Charlie Gonzalez', '(202) 225-3236', 'http://gonzalez.house.gov/feedback.cfm?campaign=gonzalez&type=Contact%20Me', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000544.jpg', 'http://gonzalez.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1316, NULL, 'Lamar', 'Smith', 'TX21', '21', 'Rep. Lamar Smith', '(202) 225-4236', 'http://www.lamarsmith.house.gov/contact.asp', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000583.jpg', 'http://lamarsmith.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1317, NULL, 'Nicholas', 'Lampson', 'TX22', '22', 'Rep. Nick Lampson', '(202) 225-5951', NULL, NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000043.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1318, NULL, 'Ciro', 'Rodriguez', 'TX23', '23', 'Rep. Ciro Rodriguez', '(202) 225-4511', NULL, NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000568.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1319, NULL, 'Kenny', 'Marchant', 'TX24', '24', 'Rep. Ken Marchant', '(202) 225-6605', 'http://www.house.gov/writerep/', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001158.jpg', 'http://www.marchant.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1320, NULL, 'Lloyd', 'Doggett', 'TX25', '25', 'Rep. Lloyd Doggett', '(202) 225-4865', 'lloyd.doggett@mail.house.gov', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000399.jpg', 'http://www.house.gov/doggett/', 'D');
INSERT INTO `politicians` VALUES (1321, NULL, 'Michael', 'Burgess', 'TX26', '26', 'Rep. Mike Burgess', '(202) 225-7772', 'http://www.house.gov/writerep/', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001248.jpg', 'http://burgess.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1322, NULL, 'Solomon', 'Ortiz', 'TX27', '27', 'Rep. Solomon Ortiz', '(202) 225-7742', 'http://www.house.gov/formortiz/issue.htm', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/O/O000107.jpg', 'http://www.house.gov/ortiz', 'D');
INSERT INTO `politicians` VALUES (1323, NULL, 'Henry', 'Cuellar', 'TX28', '28', 'Rep. Henry Cuellar', '(202) 225-1640', NULL, NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001063.jpg', 'http://www.house.gov/cuellar/', 'D');
INSERT INTO `politicians` VALUES (1324, NULL, 'Gene', 'Green', 'TX29', '29', 'Rep. Gene Green', '(202) 225-1688', 'ask.gene@mail.house.gov', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000410.jpg', 'http://www.house.gov/green/', 'D');
INSERT INTO `politicians` VALUES (1325, NULL, 'Eddie', 'Johnson', 'TX30', '30', 'Rep. Eddie Bernice Johnson', '(202) 225-8885', 'http://www.house.gov/ebjohnson/contact_ebj/index.shtml', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/J/J000285.jpg', 'http://www.house.gov/ebjohnson/', 'D');
INSERT INTO `politicians` VALUES (1326, NULL, 'John', 'Carter', 'TX31', '31', 'Rep. John Carter', '(202) 225-3864', 'http://www.house.gov/writerep/', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001051.jpg', 'http://www.house.gov/carter/', 'R');
INSERT INTO `politicians` VALUES (1327, NULL, 'Pete', 'Sessions', 'TX32', '32', 'Rep. Pete Sessions', '(202) 225-2231', 'PeteS@mail.house.gov', NULL, 'TX', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000250.jpg', 'http://sessions.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1328, NULL, 'Kay', 'Hutchison', 'TX1', '1', 'Sen. Kay Hutchison', '(202) 224-5922', 'http://hutchison.senate.gov/e-mail.htm', NULL, 'TX', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/H/H001016.jpg', 'http://hutchison.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1329, NULL, 'John', 'Cornyn', 'TX2', '2', 'Sen. John Cornyn', '(202) 224-2934', 'http://cornyn.senate.gov/index.asp?f=contact&lid=1#contact', NULL, 'TX', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C001056.jpg', 'http://cornyn.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1330, NULL, 'Rob', 'Bishop', 'UT01', '1', 'Rep. Rob Bishop', '(202) 225-0453', 'http://www.house.gov/robbishop/contact/', NULL, 'UT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001242.jpg', 'http://www.house.gov/robbishop/', 'R');
INSERT INTO `politicians` VALUES (1331, NULL, 'Jim', 'Matheson', 'UT02', '2', 'Rep. Jim Matheson', '(202) 225-3011', 'http://www.house.gov/matheson/contact.shtml', NULL, 'UT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001142.jpg', 'http://www.house.gov/matheson', 'D');
INSERT INTO `politicians` VALUES (1332, NULL, 'Chris', 'Cannon', 'UT03', '3', 'Rep. Chris Cannon', '(202) 225-7751', 'cannon.ut03@mail.house.gov', NULL, 'UT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000116.jpg', 'http://chriscannon.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1333, NULL, 'Orrin', 'Hatch', 'UT1', '1', 'Sen. Orrin Hatch', '(202) 224-5251', 'http://hatch.senate.gov/index.cfm?FuseAction=Offices.Contact', NULL, 'UT', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/H/H000338.jpg', 'http://hatch.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1334, NULL, 'Robert', 'Bennett', 'UT2', '2', 'Sen. Bob Bennett', '(202) 224-5444', 'http://bennett.senate.gov/contact/email_form.html', NULL, 'UT', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B000382.jpg', 'http://bennett.senate.gov', 'R');
INSERT INTO `politicians` VALUES (1335, NULL, 'Peter', 'Welch', 'VT01', '1', 'Rep. Peter Welch', '(202) 225-4115', NULL, NULL, 'VT', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000800.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1336, NULL, 'Patrick', 'Leahy', 'VT1', '1', 'Sen. Pat Leahy', '(202) 224-4242', 'http://leahy.senate.gov/contact.html', NULL, 'VT', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/L/L000174.jpg', 'http://leahy.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1337, NULL, 'Bernard', 'Sanders', 'VT2', '2', 'Sen. Bernie Sanders', '(202) 224-5141', NULL, NULL, 'VT', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/S/S000033.jpg', NULL, 'I');
INSERT INTO `politicians` VALUES (1338, NULL, 'Donna', 'Christensen', 'VI01', '1', 'Del. Donna Christensen', '(202) 225-1790', 'donna.christensen@mail.house.gov', NULL, 'VI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000380.jpg', 'http://www.house.gov/christian-christensen/', 'D');
INSERT INTO `politicians` VALUES (1339, NULL, 'Jo Ann', 'Davis', 'VA01', '1', 'Rep. Jo Ann Davis', '(202) 225-4261', 'http://www.house.gov/writerep/', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000136.jpg', 'http://joanndavis.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1340, NULL, 'Thelma', 'Drake', 'VA02', '2', 'Rep. Thelma Drake', '(202) 225-4215', 'http://www.house.gov/formdrake/IMA/issue_subscribe.htm', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000605.jpg', 'http://drake.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1341, NULL, 'Robert', 'Scott', 'VA03', '3', 'Rep. Bobby Scott', '(202) 225-8351', NULL, NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000185.jpg', 'http://www.house.gov/scott/', 'D');
INSERT INTO `politicians` VALUES (1342, NULL, 'Randy', 'Forbes', 'VA04', '4', 'Rep. Randy Forbes', '(202) 225-6365', 'http://www.house.gov/forbes/zipauth.htm', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/F/F000445.jpg', 'http://www.house.gov/forbes/', 'R');
INSERT INTO `politicians` VALUES (1343, NULL, 'Virgil', 'Goode', 'VA05', '5', 'Rep. Virgil Goode', '(202) 225-4711', 'http://www.house.gov/writerep/', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000280.jpg', 'http://www.house.gov/goode/', 'R');
INSERT INTO `politicians` VALUES (1344, NULL, 'Bob', 'Goodlatte', 'VA06', '6', 'Rep. Bob Goodlatte', '(202) 225-5431', 'talk2bob@mail.house.gov', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/G/G000289.jpg', 'http://www.house.gov/goodlatte/', 'R');
INSERT INTO `politicians` VALUES (1345, NULL, 'Eric', 'Cantor', 'VA07', '7', 'Rep. Eric Cantor', '(202) 225-2815', 'eric.cantor@mail.house.gov', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001046.jpg', 'http://cantor.house.gov', 'R');
INSERT INTO `politicians` VALUES (1346, NULL, 'James', 'Moran', 'VA08', '8', 'Rep. Jim Moran', '(202) 225-4376', 'http://moran.house.gov/feedback.moran.cfm?campaign=moran&type=Let%27s%20Talk', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000934.jpg', 'http://moran.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1347, NULL, 'Rick', 'Boucher', 'VA09', '9', 'Rep. Rick Boucher', '(202) 225-3861', 'ninthnet@mail.house.gov', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B000657.jpg', 'http://www.house.gov/boucher/', 'D');
INSERT INTO `politicians` VALUES (1348, NULL, 'Frank', 'Wolf', 'VA10', '10', 'Rep. Frank Wolf', '(202) 225-5136', 'http://www.house.gov/wolf/email/email.html', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/W/W000672.jpg', 'http://www.house.gov/wolf/', 'R');
INSERT INTO `politicians` VALUES (1349, NULL, 'Tom', 'Davis', 'VA11', '11', 'Rep. Tom Davis', '(202) 225-1492', 'http://tomdavis.house.gov/davis_contents/center/feedback/', NULL, 'VA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000136.jpg', 'http://tomdavis.house.gov', 'R');
INSERT INTO `politicians` VALUES (1350, NULL, 'John', 'Warner', 'VA1', '1', 'Sen. John Warner', '(202) 224-2023', 'http://warner.senate.gov/contact/contactme.cfm', NULL, 'VA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/W/W000154.jpg', 'http://warner.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1351, NULL, 'Jim', 'Webb', 'VA2', '2', 'Sen. Jim Webb', '(202) 224-4024', NULL, NULL, 'VA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/W/W000803.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1352, NULL, 'Jay', 'Inslee', 'WA01', '1', 'Rep. Jay Inslee', '(202) 225-6311', 'http://www.house.gov/inslee/contact/email.html', NULL, 'WA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/I/I000026.jpg', 'http://www.house.gov/inslee/', 'D');
INSERT INTO `politicians` VALUES (1353, NULL, 'Rick', 'Larsen', 'WA02', '2', 'Rep. Rick Larsen', '(202) 225-2605', 'rick.larsen@mail.house.gov', NULL, 'WA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/L/L000560.jpg', 'http://www.house.gov/larsen/', 'D');
INSERT INTO `politicians` VALUES (1354, NULL, 'Brian', 'Baird', 'WA03', '3', 'Rep. Brian Baird', '(202) 225-3536', 'http://www.house.gov/baird/IMA/email.shtml', NULL, 'WA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001229.jpg', 'http://www.house.gov/baird/', 'D');
INSERT INTO `politicians` VALUES (1355, NULL, 'Doc', 'Hastings', 'WA04', '4', 'Rep. Doc Hastings', '(202) 225-5816', 'http://hastings.house.gov/ContactForm.aspx', NULL, 'WA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/H/H000329.jpg', 'http://hastings.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1356, NULL, 'Cathy', 'McMorris Rodgers', 'WA05', '5', 'Rep. Cathy McMorris Rodgers', '(202) 225-2006', 'cathy.mcmorris@constituentcontact.net', NULL, 'WA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001159.jpg', 'http://www.mcmorris.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1357, NULL, 'Norman', 'Dicks', 'WA06', '6', 'Rep. Norm Dicks', '(202) 225-5916', 'http://www.house.gov/dicks/contact.html', NULL, 'WA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/D/D000327.jpg', 'http://www.house.gov/dicks/', 'D');
INSERT INTO `politicians` VALUES (1358, NULL, 'Jim', 'McDermott', 'WA07', '7', 'Rep. Jim McDermott', '(202) 225-3106', 'http://www.house.gov/mcdermott/contact.shtml', NULL, 'WA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000404.jpg', 'http://www.house.gov/mcdermott/', 'D');
INSERT INTO `politicians` VALUES (1359, NULL, 'Dave', 'Reichert', 'WA08', '8', 'Rep. Dave Reichert', '(202) 225-7761', 'http://www.house.gov/reichert/IMA/issue_subscribe.htm', NULL, 'WA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000578.jpg', 'http://www.house.gov/reichert/', 'R');
INSERT INTO `politicians` VALUES (1360, NULL, 'Adam', 'Smith', 'WA09', '9', 'Rep. Adam Smith', '(202) 225-8901', 'http://www.house.gov/adamsmith/IMA/email.shtml', NULL, 'WA', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000583.jpg', 'http://www.house.gov/adamsmith/', 'D');
INSERT INTO `politicians` VALUES (1361, NULL, 'Patty', 'Murray', 'WA1', '1', 'Sen. Patty Murray', '(202) 224-2621', NULL, NULL, 'WA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/M/M001111.jpg', 'http://murray.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1362, NULL, 'Maria', 'Cantwell', 'WA2', '2', 'Sen. Maria Cantwell', '(202) 224-3441', 'http://cantwell.senate.gov/contact/index.html', NULL, 'WA', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/C/C000127.jpg', 'http://cantwell.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1363, NULL, 'Alan', 'Mollohan', 'WV01', '1', 'Rep. Alan Mollohan', '(202) 225-4172', 'http://www.house.gov/writerep/', NULL, 'WV', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M000844.jpg', 'http://www.house.gov/mollohan/', 'D');
INSERT INTO `politicians` VALUES (1364, NULL, 'Shelley', 'Capito', 'WV02', '2', 'Rep. Shelley Capito', '(202) 225-2711', 'http://www.house.gov/writerep/', NULL, 'WV', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C001047.jpg', 'http://capito.house.gov/', 'R');
INSERT INTO `politicians` VALUES (1365, NULL, 'Nick', 'Rahall', 'WV03', '3', 'Rep. Nick Rahall', '(202) 225-3452', 'http://www.rahall.house.gov/feedback.cfm?campaign=rahall&type=contact', NULL, 'WV', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000011.jpg', 'http://www.rahall.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1366, NULL, 'Robert', 'Byrd', 'WV1', '1', 'Sen. Bob Byrd', '(202) 224-3954', 'http://byrd.senate.gov/byrd_email.html', NULL, 'WV', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/B/B001210.jpg', 'http://byrd.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1367, NULL, 'Jay', 'Rockefeller', 'WV2', '2', 'Sen. Jay Rockefeller', '(202) 224-6472', 'senator@rockefeller.senate.gov', NULL, 'WV', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/R/R000361.jpg', 'http://rockefeller.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1368, NULL, 'Paul', 'Ryan', 'WI01', '1', 'Rep. Paul Ryan', '(202) 225-3031', 'http://www.house.gov/ryan/email.htm', NULL, 'WI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/R/R000577.jpg', 'http://www.house.gov/ryan/', 'R');
INSERT INTO `politicians` VALUES (1369, NULL, 'Tammy', 'Baldwin', 'WI02', '2', 'Rep. Tammy Baldwin', '(202) 225-2906', 'http://www.house.gov/formbaldwin/IMA/get_address.htm', NULL, 'WI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/B/B001230.jpg', 'http://tammybaldwin.house.gov/', 'D');
INSERT INTO `politicians` VALUES (1370, NULL, 'Ron', 'Kind', 'WI03', '3', 'Rep. Ron Kind', '(202) 225-5506', 'http://www.house.gov/kind/contact.shtml', NULL, 'WI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000188.jpg', 'http://www.house.gov/kind/', 'D');
INSERT INTO `politicians` VALUES (1371, NULL, 'Gwen', 'Moore', 'WI04', '4', 'Rep. Gwendolynne Moore', '(202) 225-4572', 'http://www.house.gov/gwenmoore/contact.shtml', NULL, 'WI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/M/M001160.jpg', 'http://www.house.gov/gwenmoore/', 'D');
INSERT INTO `politicians` VALUES (1372, NULL, 'F. James', 'Sensenbrenner', 'WI05', '5', 'Rep. Jim Sensenbrenner', '(202) 225-5101', 'sensenbrenner@mail.house.gov', NULL, 'WI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/S/S000244.jpg', 'http://www.house.gov/sensenbrenner/', 'R');
INSERT INTO `politicians` VALUES (1373, NULL, 'Thomas', 'Petri', 'WI06', '6', 'Rep. Tom Petri', '(202) 225-2476', 'http://www.house.gov/writerep/', NULL, 'WI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/P/P000265.jpg', 'http://www.house.gov/petri/', 'R');
INSERT INTO `politicians` VALUES (1374, NULL, 'David', 'Obey', 'WI07', '7', 'Rep. Dave Obey', '(202) 225-3365', 'http://obey.house.gov/HoR/WI07/Miscellaneous+Information/email+sign+up+form.htm', NULL, 'WI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/O/O000007.jpg', 'http://obey.house.gov/hor/wi07/', 'D');
INSERT INTO `politicians` VALUES (1375, NULL, 'Steve', 'Kagen', 'WI08', '8', 'Rep. Steve Kagen', '(202) 225-5665', NULL, NULL, 'WI', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/K/K000365.jpg', NULL, 'D');
INSERT INTO `politicians` VALUES (1376, NULL, 'Herb', 'Kohl', 'WI1', '1', 'Sen. Herb Kohl', '(202) 224-5653', 'http://kohl.senate.gov/gen_contact.html', NULL, 'WI', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/K/K000305.jpg', 'http://kohl.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1377, NULL, 'Russell', 'Feingold', 'WI2', '2', 'Sen. Russ Feingold', '(202) 224-5323', 'http://feingold.senate.gov/contact.html', NULL, 'WI', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/F/F000061.jpg', 'http://feingold.senate.gov/', 'D');
INSERT INTO `politicians` VALUES (1378, NULL, 'Barbara', 'Cubin', 'WY01', 'one', 'Rep. Barbara Cubin', '(202) 225-2311', 'http://www.house.gov/cubin/zip_auth.html', NULL, 'WY', NULL, 'FH', 'http://bioguide.congress.gov/bioguide/photo/C/C000962.jpg', 'http://www.house.gov/cubin/', 'R');
INSERT INTO `politicians` VALUES (1379, NULL, 'Craig', 'Thomas', 'WY1', '1', 'Sen. Craig Thomas', '(202) 224-6441', 'http://thomas.senate.gov/index.cfm?FuseAction=Contact.Home', NULL, 'WY', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/T/T000162.jpg', 'http://thomas.senate.gov/', 'R');
INSERT INTO `politicians` VALUES (1380, NULL, 'Michael', 'Enzi', 'WY2', '2', 'Sen. Mike Enzi', '(202) 224-3424', 'http://enzi.senate.gov/email.htm', NULL, 'WY', NULL, 'FS', 'http://bioguide.congress.gov/bioguide/photo/E/E000285.jpg', 'http://enzi.senate.gov/', 'R');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `states`
-- 

CREATE TABLE `states` (
  `stateID` varchar(5) NOT NULL,
  `state` varchar(50) default NULL,
  `state_abrv` varchar(2) default NULL,
  PRIMARY KEY  (`stateID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Volcar la base de datos para la tabla `states`
-- 

INSERT INTO `states` VALUES ('us_ak', 'Alaska', 'AK');
INSERT INTO `states` VALUES ('us_al', 'Alabama', 'AL');
INSERT INTO `states` VALUES ('us_ar', 'Arkansas', 'AR');
INSERT INTO `states` VALUES ('us_az', 'Arizona', 'AZ');
INSERT INTO `states` VALUES ('us_ca', 'California', 'CA');
INSERT INTO `states` VALUES ('us_co', 'Colorado', 'CO');
INSERT INTO `states` VALUES ('us_ct', 'Connecticut', 'CT');
INSERT INTO `states` VALUES ('us_dc', 'D. Columbia', 'DC');
INSERT INTO `states` VALUES ('us_de', 'Delaware', 'DE');
INSERT INTO `states` VALUES ('us_fl', 'Florida', 'FL');
INSERT INTO `states` VALUES ('us_ga', 'Georgia', 'GA');
INSERT INTO `states` VALUES ('us_hi', 'Hawaii', 'HI');
INSERT INTO `states` VALUES ('us_ia', 'Iowa', 'IA');
INSERT INTO `states` VALUES ('us_id', 'Idaho', 'ID');
INSERT INTO `states` VALUES ('us_il', 'Illinois', 'IL');
INSERT INTO `states` VALUES ('us_in', 'Indiana', 'IN');
INSERT INTO `states` VALUES ('us_ks', 'Kansas', 'KS');
INSERT INTO `states` VALUES ('us_ky', 'Kentucky', 'KY');
INSERT INTO `states` VALUES ('us_la', 'Louisiana', 'LA');
INSERT INTO `states` VALUES ('us_ma', 'Massachusetts', 'MA');
INSERT INTO `states` VALUES ('us_md', 'Maryland', 'MD');
INSERT INTO `states` VALUES ('us_me', 'Maine', 'ME');
INSERT INTO `states` VALUES ('us_mi', 'Michigan', 'MI');
INSERT INTO `states` VALUES ('us_mn', 'Minnesota', 'MN');
INSERT INTO `states` VALUES ('us_mo', 'Missouri', 'MO');
INSERT INTO `states` VALUES ('us_ms', 'Mississippi', 'MS');
INSERT INTO `states` VALUES ('us_mt', 'Montana', 'MT');
INSERT INTO `states` VALUES ('us_nc', 'North Carolina', 'NC');
INSERT INTO `states` VALUES ('us_nd', 'North Dakota', 'ND');
INSERT INTO `states` VALUES ('us_ne', 'Nebraska', 'NE');
INSERT INTO `states` VALUES ('us_nh', 'New Hampshire', 'NH');
INSERT INTO `states` VALUES ('us_nj', 'New Jersey', 'NJ');
INSERT INTO `states` VALUES ('us_nm', 'New Mexico', 'NM');
INSERT INTO `states` VALUES ('us_nv', 'Nevada', 'NV');
INSERT INTO `states` VALUES ('us_ny', 'New York', 'NY');
INSERT INTO `states` VALUES ('us_oh', 'Ohio', 'OH');
INSERT INTO `states` VALUES ('us_ok', 'Oklahoma', 'OK');
INSERT INTO `states` VALUES ('us_or', 'Oregon', 'OR');
INSERT INTO `states` VALUES ('us_pa', 'Pennsylvania', 'PA');
INSERT INTO `states` VALUES ('us_pr', 'Puerto Rico', 'PR');
INSERT INTO `states` VALUES ('us_ri', 'Rhode Island', 'RI');
INSERT INTO `states` VALUES ('us_sc', 'South Carolina', 'SC');
INSERT INTO `states` VALUES ('us_sd', 'South Dakota', 'SD');
INSERT INTO `states` VALUES ('us_tn', 'Tennessee', 'TN');
INSERT INTO `states` VALUES ('us_tx', 'Texas', 'TX');
INSERT INTO `states` VALUES ('us_ut', 'Utah', 'UT');
INSERT INTO `states` VALUES ('us_va', 'Virginia', 'VA');
INSERT INTO `states` VALUES ('us_vt', 'Vermont', 'VT');
INSERT INTO `states` VALUES ('us_wa', 'Washington', 'WA');
INSERT INTO `states` VALUES ('us_wi', 'Wisconsin', 'WI');
INSERT INTO `states` VALUES ('us_wv', 'West Virginia', 'WV');
INSERT INTO `states` VALUES ('us_wy', 'Wyoming', 'WY');
