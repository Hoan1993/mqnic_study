package org.zerock.config;


import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.zerock.security.CustomLoginSuccessHandler;
import org.zerock.security.CustomUserDetailsService;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Setter(onMethod_ = @Autowired)
    private DataSource dataSource;

    @Bean
    public UserDetailsService customUserService() {
        return new CustomUserDetailsService();
    }

 /*   @Bean
    public AuthenticationSuccessHandler loginSuccessHandler() {
        return new CustomLoginSuccessHandler();
    }*/

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
        repo.setDataSource(dataSource);
        return repo;
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {

        CharacterEncodingFilter filter = new CharacterEncodingFilter();

        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true);
        http.addFilterBefore(filter, CsrfFilter.class);
        // 이 부분이 추가되었다.
        // SpringSecurity 사용시, 한글 깨짐 문제를 방지하기 위해.



        http.authorizeRequests()
                .antMatchers("/sample/all").permitAll()
                .antMatchers("/sample/admin").access("hasRole('ROLE_ADMIN')")
                .antMatchers("/sample/member").access("hasRole('ROLE_MEMBER')")
                .antMatchers("/board/register").access("hasRole('ROLE_ADMIN')");



        http.formLogin()
                .loginPage("/customLogin")
                .loginProcessingUrl("/login");
               /* .successHandler(loginSuccessHandler());*/

        http.logout()
                .logoutUrl("/customLogout")
                .invalidateHttpSession(true)
                .deleteCookies("remember-me", "JSESSION_ID");

        http.rememberMe()
                .key("zerock")
                .tokenRepository(persistentTokenRepository())
                .tokenValiditySeconds(604800);


    }



/*    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        log.info("configure..........................");
        auth.inMemoryAuthentication().withUser("admin")
                .password("{noop}admin").roles("ADMIN");
        auth.inMemoryAuthentication().withUser("member")
                .password("$2a$10$sQEmk27el8266eRB9ppRuu1vJNmqguhWSw/lwRx3Uw9Jrntezr7eq").roles("MEMBER");
    }*/

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        log.info("configure JDBC..........................");

        auth.userDetailsService(customUserService()).passwordEncoder(passwordEncoder());

        /*String queryUser = "select userid, userpw, enabled from tbl_member where userid = ?";
        String queryDetails = "select userid, auth from tbl_member_auth where userid = ?";

        auth.jdbcAuthentication()
                .dataSource(dataSource)
                .passwordEncoder(passwordEncoder())
                .usersByUsernameQuery(queryUser)
                .authoritiesByUsernameQuery(queryDetails);*/

    }

}
