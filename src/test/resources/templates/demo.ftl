package ${packageName}.service;

import java.util.List;
import ${packageName}.entity.vo.${ClassName}VO;
import ${packageName}.entity.bo.${ClassName}QueryBO;
import ${packageName}.entity.bo.${ClassName}AddBO;
import ${packageName}.entity.bo.${ClassName}UpdateBO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * <p>
 * ${businessName!} 服务类
 * </p>
 *
 * @author ${author}
 * @since ${createTime}
 */
public interface  ${ClassName}Service  {

/**
     * 查询${businessName}
     *
     * @param ${pkColumn.javaField} 主键
     * @return ${businessName}
     */
    ${ClassName}VO queryById(${pkColumn.javaType} ${pkColumn.javaField});

    /**
     * 分页查询${businessName}列表
     *
     * @param bo 	   查询条件
     * @param query    查询对象
     * @return ${businessName}分页列表
     */
    Page<${ClassName}VO> listPage(${ClassName}QueryBO bo, PageRequest query);

    /**
     * 查询符合条件的${businessName}列表
     *
     * @param bo 查询条件
     * @return ${businessName}列表
     */
    List<${ClassName}VO> queryList(${ClassName}QueryBO bo);

    /**
     * 新增${businessName}
     *
     * @param bo ${businessName}
     * @return 是否新增成功
     */
    Boolean insertByBo(${ClassName}AddBO bo);

    /**
     * 修改${businessName}
     *
     * @param bo ${businessName}
     * @return 是否修改成功
     */
    Boolean updateByBo(${ClassName}UpdateBO bo);

    /**
     * 校验并批量删除${businessName}信息
     *
     * @param ids     待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteByIds(List<${pkColumn.javaType}> ids);

}
