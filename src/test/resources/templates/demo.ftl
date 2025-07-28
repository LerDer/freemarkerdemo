package ${packageName}.entity;
<#function underlineToCamel str>
    <#if !str?has_content>
        <#return str>
    </#if>
    <#local parts = str?split("_")>
    <#local result = parts[0]?lower_case>
    <#list parts[1..] as part>
        <#if part?has_content>
            <#local result = result + part?lower_case?cap_first>
        </#if>
    </#list>
    <#return result>
</#function>

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
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GeneratedValue;

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
<#if isSwagger>
@Schema(name = "${ClassName} 实体类" , description = "${businessName!} 实体类" )
</#if>
@Entity
@Table(name="${tableName}")
public class ${ClassName} implements Serializable {

private static final long serialVersionUID = 1L;
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list columns as column>

	<#if column.columnComment != "">
		<#if isSwagger>
    @Schema(description = "${column.columnComment}"<#if column.defaultValue != "">, defaultValue = "${column.defaultValue}"</#if>)
		<#else>
    /**
    * ${column.columnComment}
    */
		</#if>
	</#if>
    <#if column.isPk>
    <#-- 主键 -->
    @Id
    @GeneratedValue
    @Column(name = "${column.columnName}")
    <#-- 普通字段 -->
    <#else>
    @Column(name = "${column.columnName}")
    </#if>
	<#if column.javaType=='Date' || column.javaType=='LocalDateTime'>
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private ${column.javaType} ${column.javaField};
    <#else>
    private ${column.javaType} ${column.javaField};
    </#if>
</#list>
<#-----------  END 字段循环遍历  ---------->
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
