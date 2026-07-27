package net.biancheng.campusspringboot.repository;

import net.biancheng.campusspringboot.entity.AcademicPrograms;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AcademicProgramsRepository extends JpaRepository<AcademicPrograms, Long> {
    List<AcademicPrograms> findAllByOrderByIdAsc();
}