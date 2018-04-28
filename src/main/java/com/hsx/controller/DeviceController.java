package com.hsx.controller;

import com.alibaba.dubbo.remoting.exchange.Response;
import com.github.pagehelper.PageInfo;
import com.hsx.model.Coordinate;
import com.hsx.model.Device;
import com.hsx.model.Employee;
import com.hsx.service.DeviceService;
import com.hsx.service.EmployeeService;
import com.hsx.type.DeviceType;
import com.hsx.util.MsgResponse;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by xing on 18/4/11.
 */
@RequestMapping("/device")
@Controller
public class DeviceController {

    @Autowired
    private DeviceService deviceService;

    @Autowired
    private EmployeeService employeeService;

    @ResponseBody
    @RequestMapping(value = "/getDevAll",method = RequestMethod.GET)
    public MsgResponse getDevAll(){
        List<Device> devices=deviceService.getDevAll();
        Coordinate coordinate=null;
        Coordinate[] coordinates=new Coordinate[devices.size()];
        for (int i=0;i<devices.size();i++) {
            coordinate=new Coordinate(devices.get(i).getX(),devices.get(i).getY());
            coordinates[i]=coordinate;
        }
        return MsgResponse.success().add("coordinates",coordinates);
    }

    @ResponseBody
    @RequestMapping("/devByPage")
    public MsgResponse getDevWithJson(@RequestParam(value = "pn",defaultValue = "1",required = false)Integer pn){
        PageInfo<Device> pageInfoDev=deviceService.getDevByPage(pn);
        return MsgResponse.success().add("pageInfoDev",pageInfoDev);

    }

    @ResponseBody
    @RequestMapping(value = "/devByTypeAndStatus",method = RequestMethod.POST)
    public MsgResponse getDevByTypeAndStatusByPage(@RequestParam(value = "devType",defaultValue = "1",required = false)Integer devType,
                                                   @RequestParam(value = "status",defaultValue = "0",required = false)Integer status,
                                                   @RequestParam(value = "pn",defaultValue = "1",required = false)Integer pn){
        PageInfo<Device> pageInfoDev=null;
        if (status.intValue()==0){
            pageInfoDev=deviceService.getDevByTypeAndStatus(devType,null,pn);
        }else if (status.intValue()==1){
            pageInfoDev=deviceService.getDevByTypeAndStatus(devType,1,pn);
        }else {
            pageInfoDev=deviceService.getDevByTypeAndStatus(devType,2,pn);
        }

        return MsgResponse.success().add("pageInfoDev",pageInfoDev);
    }


    @ResponseBody
    @RequestMapping("/getDevType")
    public MsgResponse getDevType(){
        List<String> devTypeValues=new ArrayList<String>();
        DeviceType[] deviceTypes=DeviceType.values();
        for (DeviceType deviceType:deviceTypes){
            devTypeValues.add(deviceType.getDesc());
        }
        return MsgResponse.success().add("devTypeValues",devTypeValues);
    }

    @ResponseBody
    @RequestMapping(value = "/addDevice",method = RequestMethod.POST)
    public MsgResponse addDevice(Device device){
        device.setStatus(2);
        device=deviceService.addDevice(device);
        return MsgResponse.success();
    }

    @ResponseBody
    @RequestMapping(value = "/getDevById/{id}",method = RequestMethod.GET)
    public MsgResponse getDevById(@PathVariable("id")Integer id){
        Device device=deviceService.getDevById(id);
        return MsgResponse.success().add("device",device);
    }

    @ResponseBody
    @RequestMapping(value = "/dev/{id}",method = RequestMethod.PUT)
    public MsgResponse updateDev(Device device){
        deviceService.updateDev(device);
        return MsgResponse.success();
    }

    //根据资产状态查询资产
    @ResponseBody
    @RequestMapping(value ="/getDevsByStatus",method = RequestMethod.GET)
    public MsgResponse getDevsByStatus(@RequestParam(value = "status",defaultValue = "1")Integer status,
                                       @RequestParam(value = "pn",defaultValue = "1")Integer pn){

        PageInfo<Device>  pageInfo=deviceService.getDevByTypeAndStatus(null,status,pn);
        return MsgResponse.success().add("pageInfo",pageInfo);
    }


    /**
     * 单个和批量删除二合一
     * 批量删除:1-2-3
     * 单个删除:1
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/dev/{ids}",method = RequestMethod.DELETE)
    public MsgResponse deleteDevById(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            List<Integer> del_ids=new ArrayList<Integer>();
            String[] str_ids=ids.split("-");
            //组装id的集合
            for (String string :str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            deviceService.deleteDevBatch(del_ids);
        }else {
            deviceService.deleteDevById(Integer.parseInt(ids));
        }

        return MsgResponse.success();
    }

    @ResponseBody
    @RequestMapping(value = "/deviceToEmp",method = RequestMethod.GET)
    public MsgResponse deviceToEmp(@RequestParam("deviceId")Integer deviceId,@RequestParam("empId")Integer empId){
        if (null==deviceId){
            return MsgResponse.fail().add("msg","失败:资产id为空!");
        }

        if (null==empId||empId.intValue()==0){
            return MsgResponse.fail().add("msg","失败:员工id为空!");
        }

        Device device=deviceService.getDevById(deviceId);
        if (device==null){
            return MsgResponse.fail().add("msg","失败!获取资产失败!");
        }

        int status=device.getStatus();
        if (status==3||status==4){
            return MsgResponse.fail().add("msg","失败:维修和废弃资产不可以分配给员工!");
        }

        if (device.getDevType().intValue()==5){
            return MsgResponse.fail().add("msg","失败:共用资产类型不可以分配给员工!");
        }

        device.setStatus(1);

        Employee employee=new Employee();
        employee.setId(empId);
        device.setEmp(employee);

        deviceService.updateDevOnlyEmpId(device);

        return MsgResponse.success().add("msg","处理成功!");
    }

    @ResponseBody
    @RequestMapping(value = "/getDevsByempId",method = RequestMethod.GET)
    public MsgResponse getDevsByempId(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                                      HttpServletRequest request){
        Employee employee=(Employee) request.getSession().getAttribute("emp");
        if (null==employee){
            return MsgResponse.fail();
        }
        PageInfo<Device> pageInfo=deviceService.getDevsByempId(employee.getId(),pn);
        return MsgResponse.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping(value = "/getDevsListByEmpId",method = RequestMethod.GET)
    public MsgResponse getDevsListByEmpId(HttpServletRequest request){
        Employee employee=(Employee) request.getSession().getAttribute("emp");
        if (null==employee){
            return MsgResponse.fail();
        }
        List<Device> devices=deviceService.getDevsByempId(employee.getId());

        Coordinate coordinate=null;
        Coordinate[] coordinates=new Coordinate[devices.size()];
        for (int i=0;i<devices.size();i++) {
            coordinate=new Coordinate(devices.get(i).getX(),devices.get(i).getY());
            coordinates[i]=coordinate;
        }
        return MsgResponse.success().add("coordinates",coordinates);
    }

    @ResponseBody
    @RequestMapping(value ="/checkQualify",method = RequestMethod.GET)
    public MsgResponse checkQualify(HttpServletRequest request){
        Employee employee=(Employee) request.getSession().getAttribute("emp");
        if (null==employee){
            return MsgResponse.fail().add("msg","您还没有登录!");
        }

        if (employee.getEmpType().intValue()==1){
            return MsgResponse.fail().add("msg","您没有权限!");
        }
        return MsgResponse.success();
    }

    @ResponseBody
    @RequestMapping(value = "/exportDevByStatus",method = RequestMethod.GET)
    public MsgResponse exportDevByStatus(@RequestParam("status")Integer status, HttpServletRequest request){

        String[] titles={"Id","资产设备","资产类型","价格","所处状态","坐标","所配员工","员工部门"};
        List<Device> list=deviceService.getDevsByStatus(status);
        exportDev(titles,list);
        return MsgResponse.success();
    }


    @ResponseBody
    @RequestMapping(value = "/exportDev",method = RequestMethod.GET)
    public MsgResponse exportDev(HttpServletRequest request){

        try {
            String[] titles={"Id","资产设备","资产类型","价格","所处状态","坐标"};

            Employee employee=(Employee) request.getSession().getAttribute("emp");
            if (null==employee){
                return MsgResponse.fail();
            }
            List<Device> list=deviceService.getDevsByempId(employee.getId());
            exportDev(titles,list);
            return MsgResponse.success();

        } catch (Exception e) {
            e.printStackTrace();
            return MsgResponse.fail();
        }

    }


    public void exportDev(String[] titles, List<Device> list) {
        // 第一步，创建一个workbook，对应一个Excel文件
        HSSFWorkbook workbook=new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet hssfSheet = workbook.createSheet("sheet1");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow hssfRow = hssfSheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle hssfCellStyle = workbook.createCellStyle();
        hssfCellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        HSSFCell hssfCell = null;
        for (int i=0;i<titles.length;i++){
            hssfCell = hssfRow.createCell(i);//列索引从0开始
            hssfCell.setCellValue(titles[i]);//列名1
            hssfCell.setCellStyle(hssfCellStyle);//列居中显示
        }


        // 第五步，写入实体数据
        if (list!=null && !list.isEmpty()){

            if (titles.length>6){
                for (int i=0;i<list.size();i++){
                    hssfRow = hssfSheet.createRow(i+1);
                    Device device=list.get(i);
                    //第六步，创建单元格，并设置值
                    hssfRow.createCell(0).setCellValue(device.getId());
                    hssfRow.createCell(1).setCellValue(device.getDevName());

                    switch (device.getDevType()){
                        case 1:hssfRow.createCell(2).setCellValue("手机");break;
                        case 2:hssfRow.createCell(2).setCellValue("电脑");break;
                        case 3:hssfRow.createCell(2).setCellValue("插线板");break;
                        case 4:hssfRow.createCell(2).setCellValue("显示器");break;
                        case 5:hssfRow.createCell(2).setCellValue("共用资产");break;
                        case 6:hssfRow.createCell(2).setCellValue("其他类型");break;
                    }


                    hssfRow.createCell(3).setCellValue(device.getPrice());
                    switch (device.getStatus()){
                        case 1:hssfRow.createCell(4).setCellValue("使用中");break;
                        case 2:hssfRow.createCell(4).setCellValue("未使用且无损坏");break;
                        case 3:hssfRow.createCell(4).setCellValue("维修中");break;
                        case 4:hssfRow.createCell(4).setCellValue("废弃");break;
                    }

                    hssfRow.createCell(5).setCellValue("("+device.getX()+","+device.getY()+")");
                    if (device.getEmp()!=null){
                        hssfRow.createCell(6).setCellValue(device.getEmp().getName());
                        hssfRow.createCell(7).setCellValue(device.getEmp().getDepartment().getDeptName());
                    }
                }

            }else {

                for (int i=0;i<list.size();i++){
                    hssfRow = hssfSheet.createRow(i+1);
                    Device device=list.get(i);
                    //第六步，创建单元格，并设置值
                    hssfRow.createCell(0).setCellValue(device.getId());
                    hssfRow.createCell(1).setCellValue(device.getDevName());
                    switch (device.getDevType()){
                        case 1:hssfRow.createCell(2).setCellValue("手机");break;
                        case 2:hssfRow.createCell(2).setCellValue("电脑");break;
                        case 3:hssfRow.createCell(2).setCellValue("插线板");break;
                        case 4:hssfRow.createCell(2).setCellValue("显示器");break;
                        case 5:hssfRow.createCell(2).setCellValue("共用资产");break;
                        case 6:hssfRow.createCell(2).setCellValue("其他类型");break;
                    }
                    hssfRow.createCell(3).setCellValue(device.getPrice());
                    switch (device.getStatus()){
                        case 1:hssfRow.createCell(4).setCellValue("使用中");break;
                        case 2:hssfRow.createCell(4).setCellValue("未使用且无损坏");break;
                        case 3:hssfRow.createCell(4).setCellValue("维修中");break;
                        case 4:hssfRow.createCell(4).setCellValue("废弃");break;
                    }
                    hssfRow.createCell(5).setCellValue("("+device.getX()+","+device.getY()+")");

                }

            }

        }

        try {
            FileOutputStream outputStream=new FileOutputStream(File.separator+"Users"+ File.separator+"xing"+File.separator+"Desktop"+File.separator+"DeviceInfo.xlsx");
            workbook.write(outputStream);
            outputStream.flush();
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
