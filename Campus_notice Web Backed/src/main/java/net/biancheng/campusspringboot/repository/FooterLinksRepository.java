package net.biancheng.campusspringboot.repository;

import net.biancheng.campusspringboot.entity.FooterLinks;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FooterLinksRepository extends JpaRepository<FooterLinks, Long> {
    List<FooterLinks> findAllByOrderBySectionAscSortOrderAsc();
}