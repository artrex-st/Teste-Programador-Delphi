/*
SQLyog Ultimate v12.14 (64 bit)
MySQL - 4.1.14-standard-log : Database - teste_prg_user1
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`teste_prg_user1` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `teste_prg_user1`;

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `codcli` int(11) NOT NULL auto_increment,
  `nome` varchar(100) NOT NULL default '',
  `cidade` varchar(100) NOT NULL default '',
  `uf` char(2) NOT NULL default '',
  PRIMARY KEY  (`codcli`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `clientes` */

insert  into `clientes`(`codcli`,`nome`,`cidade`,`uf`) values 
(1,'nome 1','ribeirao preto','SP'),
(2,'nome 2','santos','SP'),
(3,'nome 3','sao paulo','SP'),
(4,'nome 4','sao simao','SP'),
(5,'nome 5','franca','SP'),
(6,'nome 6','caconde','SP'),
(7,'nome 7','tambau','SP'),
(8,'nome 8','rio de janeiro','rj'),
(9,'nome 9','niteroi','rj'),
(10,'nome 10','pretropolis','rj'),
(11,'nome 11','nova friburgo','rj'),
(12,'nome 12','duque de caxias','rj'),
(13,'nome 13','cabo frio','rj'),
(14,'nome 14','paraty','rj'),
(15,'nome 15','belo horizonte','mg'),
(16,'nome 16','uberlandia','mg'),
(17,'nome 17','ouro preto','mg'),
(18,'nome 18','maringa','mg'),
(19,'nome 19','juiz de fora','mg'),
(20,'nome 20','santa luzia','mg');

/*Table structure for table `controle` */

DROP TABLE IF EXISTS `controle`;

CREATE TABLE `controle` (
  `cod` int(11) NOT NULL auto_increment,
  `descricao` varchar(40) default NULL,
  `numero_pedido` int(11) default '1',
  PRIMARY KEY  (`cod`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `controle` */

insert  into `controle`(`cod`,`descricao`,`numero_pedido`) values 
(1,'Sequencial do Pedido proximo pedido',1);

/*Table structure for table `dados_gerais_pedido` */

DROP TABLE IF EXISTS `dados_gerais_pedido`;

CREATE TABLE `dados_gerais_pedido` (
  `num_pedido` int(11) NOT NULL default '0',
  `cod_cli` int(11) NOT NULL default '0',
  `data_emicao` date default NULL,
  `valor_total` decimal(10,2) default '0.00',
  PRIMARY KEY  (`num_pedido`),
  KEY `fk_dados_gerais_pe_cli` (`cod_cli`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `dados_gerais_pedido` */

/*Table structure for table `produtos` */

DROP TABLE IF EXISTS `produtos`;

CREATE TABLE `produtos` (
  `codite` int(11) NOT NULL auto_increment,
  `descri` varchar(100) default NULL,
  `valor_custo` decimal(10,2) default NULL,
  PRIMARY KEY  (`codite`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `produtos` */

insert  into `produtos`(`codite`,`descri`,`valor_custo`) values 
(1,'produto 1',1.20),
(2,'produto 2',5.55),
(3,'produto 3',2.39),
(4,'produto 4',10.70),
(5,'produto 5',15.00),
(6,'produto 6',23.10),
(7,'produto 7',55.49),
(8,'produto 8',178.90),
(9,'produto 9',290.15),
(10,'produto 10',580.79),
(11,'produto 11',840.19),
(12,'produto 12',900.59),
(13,'produto 13',1200.09),
(14,'produto 14',1489.89),
(15,'produto 15',1515.19),
(16,'produto 16',1622.49),
(17,'produto 17',1860.39),
(18,'produto 18',2150.89),
(19,'produto 19',2400.59),
(20,'produto 20',2900.99);

/*Table structure for table `produtos_pedido` */

DROP TABLE IF EXISTS `produtos_pedido`;

CREATE TABLE `produtos_pedido` (
  `cod_ite_venda` int(11) NOT NULL auto_increment,
  `num_pedido_geral` int(11) NOT NULL default '0',
  `cod_produto` int(11) NOT NULL default '0',
  `quantidade` int(10) NOT NULL default '0',
  `valor_uni_pedido` decimal(10,2) NOT NULL default '0.00',
  `valor_total_pedido` decimal(10,2) NOT NULL default '0.00',
  PRIMARY KEY  (`cod_ite_venda`),
  KEY `fk_prod_pe_prod` (`cod_produto`),
  KEY `fk_prod_pe_geral` (`num_pedido_geral`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `produtos_pedido` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
