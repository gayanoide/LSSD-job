INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_lssd', 'lssd', 1);

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(null , 'society_lssd', 0, null);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_lssd', 'lssd', 1);

INSERT INTO `jobs` (`name`, `label`) VALUES
('lssd', 'lssd');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('lssd', 0, 'recrue', 'Recrue', 0, '', ''),
('lssd', 1, 'offi1', 'Officier I', 0, '', ''),
('lssd', 2, 'offi2', 'officier II', 0, '', ''),
('lssd', 3, 'off3', 'officier III', 0, '', ''),
('lssd', 4, 'sergent1', 'Sergent I', 0, '', ''),
('lssd', 5, 'sergent2', 'Sergent II', 0, '', ''),
('lssd', 6, 'lieut1', 'Lieutenant', 0, '', ''),
('lssd', 7, 'lieut2', 'Lieutenant II', 0, '', ''),
('lssd', 8, 'boss', 'Capitaine', 0, '', ''),
('lssd', 9, 'boss', 'Commandant', 0, '', '');