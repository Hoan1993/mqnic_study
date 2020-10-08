package org.zerock.persistence;


import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;

import javax.sql.DataSource;
import java.sql.Connection;

import static org.junit.Assert.fail;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class DataSourceTests {

    @Setter(onMethod = @_({@Autowired}))
    private DataSource dataSource;

    @Setter(onMethod = @_({@Autowired}))
    private SqlSessionFactory sqlSessionFactory;


    @Test
    public void TestConnection() {

        try(Connection con = dataSource.getConnection()) {
            log.info(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testMyBatis() {
        try(SqlSession session = sqlSessionFactory.openSession();
            Connection con = session.getConnection();
            ) {
            log.info(session);
            log.info(con);
            log.info("hihihihihi");
        } catch (Exception e) {
            fail(e.getMessage());
        }

    }



}
