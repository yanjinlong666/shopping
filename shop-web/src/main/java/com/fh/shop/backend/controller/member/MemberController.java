package com.fh.shop.backend.controller.member;

import com.fh.core.common.DataTableResult;
import com.fh.core.common.ServiceResponse;
import com.fh.shop.backend.biz.member.IMemberService;
import com.fh.shop.backend.po.member.Member;
import com.fh.shop.backend.vo.MemberVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

@Controller
@RequestMapping("/member")
public class MemberController {
    @Resource(name = "memberService")
    private IMemberService memberService;

    /**
     * 会员展示
     */
    @RequestMapping("/list")
    @ResponseBody
    public ServiceResponse list(Member member){
        //构建datatable需要的数据
        DataTableResult dataTableResult = memberService.buildDataTable(member);
        //响应数据到前台
        return ServiceResponse.success(dataTableResult);
    }
    /**
     * 去展示页面
     */
    @RequestMapping("toMemberList")
    public String toMemberList(){
        return "member/memberList";
    }
    /**
     * 修改回显
     */
    @RequestMapping("/toUpdateMember")
    public ModelAndView toUpdateMember(Integer id){
        MemberVo memberVo = memberService.queryMemberById(id);
        ModelAndView modelAndView = new ModelAndView("member/updateMember");
        modelAndView.addObject("member",memberVo);
        return modelAndView;
    }
    /**
     * 修改会员基本信息
     */
    @RequestMapping("/updateMember")
    @ResponseBody
    public ServiceResponse updateMember(Member member){
        return memberService.updateMember(member);
    }
}
