-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('trade_result', '1', '1', 'result', 'system/result/index', 1, 0, 'C', '0', '0', 'system:result:list', '#', 'admin', sysdate(), '', null, 'trade_result菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('trade_result查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:result:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('trade_result新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:result:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('trade_result修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:result:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('trade_result删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:result:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('trade_result导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:result:export',       '#', 'admin', sysdate(), '', null, '');
