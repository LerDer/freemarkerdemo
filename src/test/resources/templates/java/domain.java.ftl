package ${packageName}.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
<#if hasDecimalField>
import java.math.BigDecimal;
</#if>
<#if hasTimeField>
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
</#if>
import lombok.Data;


/**
 * ${functionName}对象 ${tableName}
 *
 * @author ${author}
 * @date ${createTime}
 */
@Data
@TableName("${tableName}")
@ApiModel(value = "BusinessName 对象", description = "${functionName}")
public class ${BusinessName} extends ${Entity} {

private static final long serialVersionUID = 1L;

<#if pkColumn??>
@ApiModelProperty(value = "${pkColumn.columnComment}")
@TableId(value = "${pkColumn.columnName}", type = IdType.AUTO)
private Long applicationId;
</#if>


<#list columns as column>
#if(!$table.

isSuperColumn($column.javaField))
		/**
		 * $column.columnComment
		 */
		#if($column.javaField=='delFlag')
    @TableLogic
#end
#if($column.javaField=='version')
    @Version
#end
#if($column.isPk==1)
    @TableId(value = "$column.columnName")
#end
    private $column.javaType $column.javaField;

#end
</#list>

}