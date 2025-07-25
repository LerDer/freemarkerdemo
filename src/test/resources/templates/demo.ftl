-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
values('${businessName}', '${parentMenuId}', '1', '${className}', '${moduleName}/${className}/index', 1, 0, 'C', '0', '0', '${permissionPrefix}:list', '#', 103, 1, sysdate(), null, null, '${businessName}菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
values('${businessName}查询',@parentId, '1',  '#', '', 1, 0, 'F', '0', '0', '${permissionPrefix}:query',        '#', 103, 1, sysdate(), null, null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
values('${businessName}新增',@parentId, '2',  '#', '', 1, 0, 'F', '0', '0', '${permissionPrefix}:add',          '#', 103, 1, sysdate(), null, null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
values('${businessName}修改',@parentId, '3',  '#', '', 1, 0, 'F', '0', '0', '${permissionPrefix}:edit',         '#', 103, 1, sysdate(), null, null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
values('${businessName}删除',@parentId, '4',  '#', '', 1, 0, 'F', '0', '0', '${permissionPrefix}:remove',       '#', 103, 1, sysdate(), null, null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
values('${businessName}导出',@parentId, '5',  '#', '', 1, 0, 'F', '0', '0', '${permissionPrefix}:export',       '#', 103, 1, sysdate(), null, null, '');
