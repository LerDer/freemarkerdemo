package ${packageName}.entity;

import java.io.Serializable;
<#if hasTimeField>
import java.util.Date;
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
</#if>
<#if hasDecimalField>
import java.math.BigDecimal;
</#if>
<#if isSwagger>
import io.swagger.v3.oas.annotations.media.Schema;
</#if>
<#if isLombok>
import lombok.Data;
</#if>
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
<#if isArModel>
import com.baomidou.mybatisplus.extension.activerecord.Model;
</#if>
/**
* <p>
* ${businessName!}
* </p>
*
* @author ${author}
* @since ${createTime}
*/
<#if isLombok>
@Data
</#if>
@TableName("${tableName}")
<#if isSwagger>
@Schema(name = "${ClassName} 实体类" , description = "${businessName!} 实体类" )
</#if>
<#if isArModel>
public class ${ClassName} extends Model<${ClassName}> {
<#else>
public class ${ClassName} implements Serializable {
</#if>

    private static final long serialVersionUID = 1L;
    <#-- ----------  BEGIN 字段循环遍历  ---------->
<#list columns as column>

<#if column.columnComment != "">
<#if isSwagger>
    @Schema(description = "${column.columnComment}" <#if column.defaultValue != "">, defaultValue = "${column.defaultValue}"</#if>)
<#else>
    /**
    * ${column.columnComment}
    */
</#if>
</#if>
    <#if column.isPk>
    <#-- 主键 -->
    @TableId(value = "${column.columnName}", type = IdType.AUTO)
    <#-- 普通字段 -->
    <#elseif column.columnName == createTime>
    @TableField(fill = FieldFill.INSERT)
    <#elseif column.columnName == updateTime>
    @TableField(fill = FieldFill.UPDATE)
    <#elseif column.columnName == version>
    @Version
    <#elseif column.columnName == logicDelete>
    @TableLogic
    </#if>
<#if column.javaType=='Date' || column.javaType=='LocalDateTime'>
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8" )
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss" )
    private ${column.javaType} ${column.javaField};
<#else>
    private ${column.javaType} ${column.javaField};
</#if>
</#list>
<#------------  END 字段循环遍历  ---------->

<#if !isLombok>
<#list columns as column>
<#if column.javaType == "boolean">
<#assign getprefix="is"/>
<#else>
<#assign getprefix="get"/>
</#if>
    public ${column.javaType} ${getprefix}${column.capJavaField}(){
        return ${column.javaField};
    }

    public void set${column.capJavaField}(${column.javaType} ${column.javaField}) {
        this.${column.javaField} = ${column.javaField};
    }
</#list>
</#if>


<#if isArModel>
    @Override
    public Serializable pkVal() {
        return this.${pkColumn.javaField};
    }
</#if>

<#if !isLombok>
    @Override
    public String toString() {
        return "${ClassName}{" +
<#list columns as column>
<#if column_index==0>
        "${column.javaField}=" + ${column.javaField} +
<#else>
        ", ${column.javaField}=" + ${column.javaField} +
</#if>
</#list>
        "}";
    }
</#if>
}
