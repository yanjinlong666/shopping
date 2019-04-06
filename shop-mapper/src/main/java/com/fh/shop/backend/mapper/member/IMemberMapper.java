package com.fh.shop.backend.mapper.member;

import com.fh.shop.backend.po.member.Member;

import java.util.List;

public interface IMemberMapper {
    List<Member> list(Member member);

    Long queryTotalCount(Member member);

    Member queryMemberById(Integer id);

    void updateMember(Member member);

    List<Member> queryMemberByName(String userName);
}
