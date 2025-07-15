<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="" prop="projectCode">
        <el-input
          v-model="queryParams.projectCode"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="area">
        <el-input
          v-model="queryParams.area"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="projectType">
        <el-select v-model="queryParams.projectType" placeholder="请选择" clearable style="width: 240px">
          <el-option label="请选择字典生成" value="" />
        </el-select>
      </el-form-item>
      <el-form-item label="" prop="dateStr">
        <el-input
          v-model="queryParams.dateStr"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="projectName">
        <el-input
          v-model="queryParams.projectName"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="sectionName">
        <el-input
          v-model="queryParams.sectionName"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="winner">
        <el-input
          v-model="queryParams.winner"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="price">
        <el-input
          v-model="queryParams.price"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="projectManager">
        <el-input
          v-model="queryParams.projectManager"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="tender">
        <el-input
          v-model="queryParams.tender"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="tenderLinkman">
        <el-input
          v-model="queryParams.tenderLinkman"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="tenderLinkmanCall">
        <el-input
          v-model="queryParams.tenderLinkmanCall"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="agency">
        <el-input
          v-model="queryParams.agency"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="agencyLinkman">
        <el-input
          v-model="queryParams.agencyLinkman"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="" prop="agencyLinkmanCall">
        <el-input
          v-model="queryParams.agencyLinkmanCall"
          placeholder="请输入"
          clearable
          style="width: 240px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['system:result:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:result:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:result:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['system:result:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="resultList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="" align="center" prop="id" />
      <el-table-column label="" align="center" prop="projectCode" />
      <el-table-column label="" align="center" prop="area" />
      <el-table-column label="" align="center" prop="projectType" />
      <el-table-column label="" align="center" prop="dateStr" />
      <el-table-column label="" align="center" prop="projectName" />
      <el-table-column label="" align="center" prop="sectionName" />
      <el-table-column label="" align="center" prop="winner" />
      <el-table-column label="" align="center" prop="price" />
      <el-table-column label="" align="center" prop="projectManager" />
      <el-table-column label="" align="center" prop="tender" />
      <el-table-column label="" align="center" prop="tenderLinkman" />
      <el-table-column label="" align="center" prop="tenderLinkmanCall" />
      <el-table-column label="" align="center" prop="agency" />
      <el-table-column label="" align="center" prop="agencyLinkman" />
      <el-table-column label="" align="center" prop="agencyLinkmanCall" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:result:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:result:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改trade_result对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="resultRef" :model="form" :rules="rules" label-width="80px">
      <el-form-item v-if="renderField(true, true)" label="" prop="projectCode">
        <el-input v-model="form.projectCode" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="area">
        <el-input v-model="form.area" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="projectType">
        <el-select v-model="form.projectType" placeholder="请选择">
          <el-option label="请选择字典生成" value="" />
        </el-select>
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="dateStr">
        <el-input v-model="form.dateStr" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="projectName">
        <el-input v-model="form.projectName" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="sectionName">
        <el-input v-model="form.sectionName" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="winner">
        <el-input v-model="form.winner" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="price">
        <el-input v-model="form.price" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="projectManager">
        <el-input v-model="form.projectManager" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="tender">
        <el-input v-model="form.tender" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="tenderLinkman">
        <el-input v-model="form.tenderLinkman" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="tenderLinkmanCall">
        <el-input v-model="form.tenderLinkmanCall" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="agency">
        <el-input v-model="form.agency" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="agencyLinkman">
        <el-input v-model="form.agencyLinkman" placeholder="请输入" />
      </el-form-item>
      <el-form-item v-if="renderField(true, true)" label="" prop="agencyLinkmanCall">
        <el-input v-model="form.agencyLinkmanCall" placeholder="请输入" />
      </el-form-item>

      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Result">
import { listResult, getResult, delResult, addResult, updateResult } from "@/api/system/result";

const { proxy } = getCurrentInstance();

const resultList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    projectCode: null,
    area: null,
    projectType: null,
    dateStr: null,
    projectName: null,
    sectionName: null,
    winner: null,
    price: null,
    projectManager: null,
    tender: null,
    tenderLinkman: null,
    tenderLinkmanCall: null,
    agency: null,
    agencyLinkman: null,
    agencyLinkmanCall: null,
  },
  rules: {
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询trade_result列表 */
function getList() {
  loading.value = true;
  listResult(queryParams.value).then(response => {
    resultList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}

/** 表单重置 */
function reset() {
  form.value = {
    id: null,
    projectCode: null,
    area: null,
    projectType: null,
    dateStr: null,
    projectName: null,
    sectionName: null,
    winner: null,
    price: null,
    projectManager: null,
    tender: null,
    tenderLinkman: null,
    tenderLinkmanCall: null,
    agency: null,
    agencyLinkman: null,
    agencyLinkmanCall: null,
  };
  proxy.resetForm("resultRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

/** 多选框选中数据  */
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加trade_result";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _id = row.id || ids.value;
  getResult(_id).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改trade_result";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["resultRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateResult(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addResult(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value;
  proxy.$modal.confirm('是否确认删除trade_result编号为"' + _ids + '"的数据项？').then(function() {
    return delResult(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}


/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/result/export', {
    ...queryParams.value
  }, `result_${new Date().getTime()}.xlsx`);
}

/** 是否渲染字段 */
function renderField(insert, edit) {
  return form.value.id == null ? insert : edit;
}

getList();
</script>