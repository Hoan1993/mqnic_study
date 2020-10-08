package org.zerock.domain;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.util.UriComponentsBuilder;

@Getter
@Setter
@ToString
public class Criteria {

    // Criteria 클래스의 용도는 pageNum과 amount 값을 같이 전달하는 용도이다.
    // 생성자를 통해서 기본값을 1페이지, 10개로 지정해서 처리한다.

    private int pageNum;
    private int amount;

    // 검색을 위해 아래 두 가지 변수가 추가되었다.
    private String type;
    private String keyword;


    public Criteria() {
        this(1, 10);
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    // getTypeArr()은 검색 조건이 각 글자(T, W, C)로 구성되어 있으므로
    // 검색조건을 배열로 만들어서 한 번에 처리하기 위함이다.
    // getTypeArr()을 이용해서 MyBatis의 동적 태그를 활용할 수 있다.
    public String[] getTypeArr() {
        return type == null? new String[] {}: type.split("");
    }


    public String getListLink() {
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
                .queryParam("pageNum", this.pageNum)
                .queryParam("amount", this.getAmount())
                .queryParam("type", this.getType())
                .queryParam("keyword", this.getKeyword());

        return builder.toUriString();
    }
}
