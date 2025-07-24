package ${packageName}.entity.bo;

import java.io.Serializable;
import ${packageName}.entity.${ClassName};
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
<#if hasRequiredField>
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.NotBlank;
import org.hibernate.validator.constraints.Length;
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
<#if isSwagger>
@Schema(name = "${ClassName}UpdateBO对象" , description = "${businessName!}修改对象" )
</#if>
public class ${ClassName}UpdateBO implements Serializable {

    private static final long serialVersionUID = 1L;
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list columns as column>

	<#if column.isEdit >
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
			<#if column.javaType=='String'>
    @NotBlank(message = "${column.columnComment}不能为空")
            	<#if column.columnLength?? && column.columnLength gt 0>
    @Length(max = ${column.columnLength}, message = "${column.columnComment}长度不能超过 ${column.columnLength}")
            	</#if>
            <#else>
    @NotNull(message = "${column.columnComment}不能为空")
            </#if>
        <#else>
            <#if column.isRequired>
                <#if column.javaType=='String'>
    @NotBlank(message = "${column.columnComment}不能为空")
                    <#if column.columnLength?? && column.columnLength gt 0>
    @Length(max = ${column.columnLength}, message = "${column.columnComment}长度不能超过 ${column.columnLength}")
                    </#if>
                <#else>
    @NotNull(message = "${column.columnComment}不能为空")
                </#if>
            </#if>
		</#if>
		<#if column.javaType=='Date' || column.javaType=='LocalDateTime'>
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8" )
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss" )
    private ${column.javaType} ${column.javaField};
		<#else>
    private ${column.javaType} ${column.javaField};
		</#if>
	</#if>
</#list>

    public static ${ClassName} convert(${ClassName}UpdateBO bo) {
        ${ClassName} ${className} =new ${ClassName}();
<#list columns as column>
	<#if column.isEdit >
        ${className}.set${column.capJavaField}(bo.get${column.capJavaField}());
	</#if>
</#list>
        return ${className};
	}

 <#if !isLombok>
 	<#list columns as column>
 		<#if column.javaType == "boolean">
		<#assign getprefix="is"/>
		<#else>
		<#assign getprefix="get"/>
		</#if>
		<#if column.isEdit >
 		<#else>
     public ${column.javaType} ${getprefix}${column.capJavaField}(){
         return ${column.javaField};
     }

     public void set${column.capJavaField}(${column.javaType} ${column.javaField}) {
         this.${column.javaField} = ${column.javaField};
     }
 		</#if>
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
