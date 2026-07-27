package net.biancheng.campusspringboot.repository;

import net.biancheng.campusspringboot.entity.NavLinks;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NavLinksRepository extends JpaRepository<NavLinks, Long> {
    List<NavLinks> findAllByOrderBySortOrderAsc();
}