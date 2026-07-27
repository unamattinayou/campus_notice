package net.biancheng.campusspringboot.repository;

import net.biancheng.campusspringboot.entity.SchoolInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SchoolInfoRepository extends JpaRepository<SchoolInfo, Long> {
    Optional<SchoolInfo> findFirstByIdNotNull();
}