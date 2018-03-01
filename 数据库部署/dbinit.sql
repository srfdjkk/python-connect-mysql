
use mysql;
update user set password=PASSWORD("root") where user='root';
FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
FLUSH PRIVILEGES;
                
create database jailsystem;
use jailsystem;


/* drop table userInfo; */

CREATE TABLE userInfo
(  
        id        int(4)    primary key NOT NULL auto_increment,  
        name      char(40)  NOT NULL default '',  
        level     char(40)  NOT NULL default '',
        psw       BLOB      NOT NULL default '',
        operTime  datetime  NOT NULL
 
) ENGINE=InnoDB DEFAULT  CHARSET=utf8; 

DELETE from userinfo where name = 'root';
DELETE from userinfo where name = 'sa';
DELETE from userinfo where name = 'abc';

INSERT INTO userinfo(id,name,level,psw,operTime) VALUES
(NULL,'root','superadmin','MD5(root)',NOW());

INSERT INTO userinfo(id,name,level,psw,operTime) VALUES
(NULL,'sa','administrator','MD5(sa)',NOW());

INSERT INTO userinfo(id,name,level,psw,operTime) VALUES
(NULL,'abc','operator','MD5(abc)',NOW());


/* drop table deviceinfo; */
CREATE TABLE deviceinfo
(
        id          int(4)    primary key NOT NULL auto_increment,
        name        char(60)  NOT NULL default '',
        sn          char(20)  NOT NULL default '', 
        port        int(5)    ,
        ipaddr      char(20)  NOT NULL default '',
        netmask     char(20)  NOT NULL default '',
        mode        char(20)  NOT NULL default '',        
        lastonline  datetime  NOT NULL
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
DELETE from deviceinfo where name = 'band1';

INSERT INTO deviceinfo(id,name,sn,port,ipaddr,netmask,mode,lastonline) VALUES
(NULL,'band1','',51888,'172.17.18.188','255.255.0.0','FDD','');
*/

/* 0 is normal user  1 is illegal user*/
CREATE TABLE imsiinfo 
(  
        id      bigint(8)    primary key NOT NULL auto_increment,  
        imsi    varchar(20)  NOT NULL default '',  
        phone_num        varchar(20)  NOT NULL default '', 
        time    datetime     NOT NULL,
        collec_area varchar(30) default '',
        type    tinyint unsigned  NOT NULL 
) ENGINE=InnoDB DEFAULT  CHARSET=utf8; 

CREATE TABLE legalinfo 
(  
        id      bigint(8)    primary key NOT NULL auto_increment,  
        phone_num    varchar(20)  NOT NULL default '',  
        sn      varchar(20)  NOT NULL default '',
        time    datetime     NOT NULL,
        collec_area varchar(30) default ''
) ENGINE=InnoDB DEFAULT  CHARSET=utf8; 

/*Black and White List */
CREATE TABLE normal_user
(
        id          bigint(8)    primary key NOT NULL auto_increment,  
        sn          varchar(20)  NOT NULL default '',
        phone_num        varchar(20)  NOT NULL default '',  
        collec_area   varchar(30)       default '',
        time        datetime     NOT NULL
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



drop table permiinfo;
CREATE TABLE permiinfo
(
        functionid       int(3)        NOT NULL,  
        functionname     varchar(60)   primary key  NOT NULL default '',
        aliasname        varchar(60)   NOT NULL default '',
        groupby          varchar(60)   NOT NULL default '',
        saenabled        tinyint(1)    NOT NULL,  
        adminenabled     tinyint(1)    NOT NULL,  
        openabled        tinyint(1)    NOT NULL,  
        otherenabled     tinyint(1)    NOT NULL,  
        level            int(3)        NOT NULL,
        parentfunction   int(3)        NOT NULL,        
        des              varchar(100)  NULL default ''
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*LTE*/
INSERT INTO permiinfo VALUES(1, 'MMenuExLog','导出日志','功能菜单',            1,1,0,1,0,0,'导出日志');
INSERT INTO permiinfo VALUES(2, 'MMenuReqOD','历史记录查询','查询菜单',        1,1,1,1,0,0,'历史记录查询');
INSERT INTO permiinfo VALUES(3, 'MMenuCfgPwd','修改密码','配置菜单',           1,1,1,0,0,0,'修改密码');
INSERT INTO permiinfo VALUES(4, 'MMenuCfgUser','用户管理','配置菜单',          1,0,0,0,0,0,'用户管理');
INSERT INTO permiinfo VALUES(5, 'MMenuCfgDB','数据库管理','配置菜单',          1,1,0,0,0,0,'数据库管理');
INSERT INTO permiinfo VALUES(6, 'MMenuCfgSys','系统配置','配置菜单',           1,0,0,0,0,0,'系统配置');
INSERT INTO permiinfo VALUES(7, 'pmDataList0','右键导出数据','实时数据查询',   1,1,0,0,0,0,'右键导出数据');
INSERT INTO permiinfo VALUES(8, 'pmDataList1','右键清屏数据','实时数据查询',   1,1,0,1,0,0,'右键清屏数据');
INSERT INTO permiinfo VALUES(9, 'pmMain0','右键导出日志','系统日志',           1,1,0,1,0,0,'右键导出日志');
INSERT INTO permiinfo VALUES(10,'pmMain1','右键清空日志','系统日志',           1,1,0,0,0,0,'右键清空日志');
INSERT INTO permiinfo VALUES(11,'btnAdvance','高级选项','AP面板',              1,1,1,0,0,0,'高级按扭');
INSERT INTO permiinfo VALUES(12,'btnBWListReq','查询','黑白名单设置',          1,1,1,1,0,0,'当前设备黑白名单查询');
INSERT INTO permiinfo VALUES(13,'btnDelBW','删除','黑白名单设置',              1,1,0,0,0,0,'黑白名单设置_删除');
INSERT INTO permiinfo VALUES(14,'btnNew','新增','黑白名单设置',                1,1,0,0,0,0,'黑白名单设置_新增');
INSERT INTO permiinfo VALUES(15,'btnClearData','清空数据','黑白名单设置',      1,1,0,0,0,0,'黑白名单设置_清空数据');
INSERT INTO permiinfo VALUES(16,'btnNewBWList','设置','黑白名单设置',          1,1,0,0,0,0,'黑白名单设置_发送设置数据');
INSERT INTO permiinfo VALUES(17,'tsCellCFG','小区设置','小区设置',             1,1,0,0,0,0,'黑白名单设置_小区配置');
INSERT INTO permiinfo VALUES(18,'btnSendData','设置','扫频',                   1,1,0,0,0,0,'扫频_发送设置数据');
INSERT INTO permiinfo VALUES(19,'btngetEarfcn','查询','扫频',                  1,1,1,0,0,0,'扫频_查询扫频频点');
INSERT INTO permiinfo VALUES(20,'tsSmallAreaActive','小区激活','小区激活',     1,1,1,0,0,0,'小区激活');
INSERT INTO permiinfo VALUES(21,'tsTedirection','用户策略设置','用户策略设置', 1,1,0,0,0,0,'用户策略设置');
INSERT INTO permiinfo VALUES(22,'tsWorkMode','工作模式','工作模式',            1,1,0,0,0,0,'工作模式');
INSERT INTO permiinfo VALUES(23,'tsModifyIP','修改IP','修改IP',                1,1,0,0,0,0,'修改IP');
INSERT INTO permiinfo VALUES(24,'btnOutExcel','导出','历史记录查询',           1,1,1,0,0,0,'历史查询导出查询');
INSERT INTO permiinfo VALUES(25,'btnReqSmAare','查询','小区配置',              1,1,1,0,0,0,'小区配置-->查询');
INSERT INTO permiinfo VALUES(26,'DeleteData','删除','历史记录信息',            1,1,1,0,0,0,'删除历史记录数据');
INSERT INTO permiinfo VALUES(27,'AuthorityManage','权限管理','配置菜单',       1,0,0,0,0,0,'权限配置管理');
INSERT INTO permiinfo VALUES(28,'btnReportInfo','设置','上报IP地址设置',       1,1,0,0,0,0,'上报IP地址设置');
INSERT INTO permiinfo VALUES(29,'btnReportReq','查询','上报IP地址设置',        1,1,0,0,0,0,'上报IP地址设置');
INSERT INTO permiinfo VALUES(30,'btnBandSet','设置','系统设置',                1,1,0,0,0,0,'系统设置');
INSERT INTO permiinfo VALUES(31,'btnBandQuery','查询','系统设置',              1,1,0,0,0,0,'系统设置');
INSERT INTO permiinfo VALUES(32,'btnUeCapReprot','查询','终端能力上报',        1,1,0,0,0,0,'终端能力上报');
INSERT INTO permiinfo VALUES(33,'btnUpdate','升级','版本升级',                 1,1,0,0,0,0,'版本升级');
INSERT INTO permiinfo VALUES(34,'btnListLogFile','获取日志','日志下载',        1,1,0,0,0,0,'系统日志下载');
INSERT INTO permiinfo VALUES(35,'btnFTPClose','关闭连接','日志下载',           1,1,0,0,0,0,'系统日志下载');
INSERT INTO permiinfo VALUES(36,'btnDownLog','下载日志','日志下载',            1,1,0,0,0,0,'系统日志下载');
INSERT INTO permiinfo VALUES(37,'btnOtherInterfaceSet','设置','非XML接口配置', 1,1,0,0,0,0,'非XML上传与查询配置');
INSERT INTO permiinfo VALUES(38,'btnOtherInterfaceQry','查询','非XML接口配置', 1,1,0,0,0,0,'非XML上传与查询配置');
INSERT INTO permiinfo VALUES(39,'btnNeighCellReq','查询','邻小区信息',         1,1,0,0,0,0,'邻小区信息');
INSERT INTO permiinfo VALUES(40,'btnSYNCQuery','查询','同步状态接口',          1,1,1,0,0,0,'同步状态接口');
INSERT INTO permiinfo VALUES(41,'btnRtInfoQuery','查询','实时信息上报',        1,1,1,0,0,0,'实时信息上报');
INSERT INTO permiinfo VALUES(42,'btnMacroSet','设置','宏网模拟设置',           1,1,0,0,0,0,'宏网模拟设置');
INSERT INTO permiinfo VALUES(43,'btnMacroQuery','查询','宏网模拟设置',         1,1,0,0,0,0,'宏网模拟设置');

/*TDS*/
INSERT INTO permiinfo VALUES(44,'btnModeReq','查询','注册状态查询',            1,1,0,0,0,0,'注册状态查询');
INSERT INTO permiinfo VALUES(45,'btnStatusSet','设置','设备状态设置',          1,1,0,0,0,0,'设备状态设置');
INSERT INTO permiinfo VALUES(46,'btnRunStatus','查询','设备状态设置',          1,1,0,0,0,0,'设备状态设置');
INSERT INTO permiinfo VALUES(47,'btnSysConfig','设置','设备参数设置',          1,1,0,0,0,0,'设备参数设置');
INSERT INTO permiinfo VALUES(48,'btnSnifferQuery','查询','扫频信息查询',       1,1,0,0,0,0,'扫频信息查询');
INSERT INTO permiinfo VALUES(49,'btnSMSQuery','查询','SMS上报信息查询',        1,1,0,0,0,0,'SMS上报信息查询');
INSERT INTO permiinfo VALUES(50,'btnMeasQry','查询','测量上报信息查询',        1,1,0,0,0,0,'测量上报信息查询');
