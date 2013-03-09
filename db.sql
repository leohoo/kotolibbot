CREATE TABLE `books` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `regno` char(15) DEFAULT NULL,
  `title` char(100) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `memo` varchar(200) DEFAULT NULL,
  `cardno` char(9) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE DEFINER=`root`@`localhost` PROCEDURE `addrecordwithcardno`(in card char(9), in reg char(15), in title char(100), in rdate date)
begin 
  select count(*) into @n from `books` where regno=reg and duedate=rdate;
  if @n=0 then 
    insert into `books` (`cardno`, `regno`, `title`, `duedate`) values (card, reg, title, rdate); 
  end if; 
end

