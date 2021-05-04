use spring;



DROP TABLE IF EXISTS VisinsaNotice;
CREATE TABLE IF NOT EXISTS VisinsaNotice(
  no INTEGER AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  writer VARCHAR(10) NOT NULL,  
  pass VARCHAR(10) NOT NULL,
  content VARCHAR(1000) NOT NULL,
  reg_date TIMESTAMP NOT NULL,
  hits INTEGER(5) NOT NULL,
  state INTEGER DEFAULT 0
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('주문 취소 및 환불 안내','관리자','1234','주문취소의 경우 게시판 또는 전화 주시면 확인 후 환불처리 해드리고 있습니다. 오후 2시 이후에는 발송업무가 끝나기에 2시 전에 연락주셔야 주문취소 및 환불처리가 원활하게 이루어질 수 있습니다. 이점 양해부탁드립니다.',now(),'200',1);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('개인정보처리방침 개정안내','관리자','1234','당사는 고객의 편의를 위해 간편로그인 방식을 제공하고 있습니다. 이와 같은 로그인 시 당사가 고객의 개인정보를 추가 수집하지 않으며, 다만 로그인 정보 식별값만 비교하고 있습니다.',now(), '100',1);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('개인정보 유효기간제 적용안내','관리자','1234','정보통신망 이용촉진 및 정보보호 등에 관한 법률 제29조 제2항의 개인정보 유효기간제에 따라 1년 이상 접속이력이 없는 회원을 대상으로 아래와 같이 휴면정책이 적용됩니다.', now(),'50',2);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('게시글 및 댓글 운영 공지','관리자','1234','댓글이 블라인드 처리될 경우, 댓글 작성자분이 해당 사유를 명확히 인지할 수 있도록 안내 기능을 개발 중에 있습니다. 1개월 이내에 개발하여 보완할 예정입니다.',now(),'25',2);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('업데이트 뉴스 게시판 댓글 규칙 공지','관리자','1234','원활한 업데이트 뉴스 게시판 운영을 위해 하기 항목 위반 시, 댓글은 블라인드 처리 되며 관리자의 판단에 따라 커뮤니티 이용이 30일 이상 차단 됩니다.',now(),'20',2);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('3월 친구 초대 이벤트 발표','김범수','1234','3월 친구 초대 이벤트에 응모해주신 분들께 진심을 담아 감사 인사를 올립니다. 이벤트 참여 자격조건을 갖춘 분들 중 당첨자 스무 분을 선정했으며 이하의 명단과 같습니다. 경품 수령 정보를 보내주시는 분들께 축하의 마음을 담아 이벤트 경품을 보내드리겠습니다.',now(),'20',0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('지금 듣고있는 노래 맞추면 선물','나얼','1234','그리고 신고 대상은 욕설글, 혐오 또는 음란 게시물, 대리게임 홍보글, 기타 홍보성 글에 한합니다.',now(),'10',0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('다른 회원님께 욕설 사용하는 분은 신고게시판에 신고해주시면 활동정지 처리하겠습니다.','박효신','1234','다른 회원님께 욕설,패드립 사용하는 분은 신고게시판에 신고해주시면 활동정지처리하도록 하겠습니다.',now(),'5',0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('8월 23일부터 거리두기 2단계 전국 확대','이수','1234','전국 클럽 감주등은 모두 운영 중단 입니다.',now(),'1',0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('검색옵션의 기능과 화면이 새롭게 개선됩니다.','박정남','1234','PC 통합검색에서 검색 옵션의 위치가 더보기 버튼 하단으로 이동하였습니다.',now(),1234,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('통합검색 우측 영역 콘텐츠 검색 서비스 일부 종료 안내','김태리','1234','앞으로 보다 나은 콘텐츠 검색 서비스 제공을 위해 서비스를 종료하게 되었습니다.',now(),5678,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('PC 내 검색어 서비스가 종료됩니다.','메이플스토리','1234','해당 서비스 종료와 관련하여 추가로 궁금하신 사항은 고객센터를 통해 알려주시면 성심껏 안내해 드리도록 하겠습니다',now(),9999,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('블로그 접속 장애 복구 완료되었습니다.','카트라이더','1234','현재는 복구가 완료되어 정상적으로 이용하실 수 있습니다.',now(),8888,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('블로그 접속 장애로 불편을 드린 점 사과드립니다.','피파','1234','갑작스러운 오류로 장시간 불편을 드린 점 진심으로 사과드립니다.',now(),7777,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('주 이스트소프트 계정 침해 대상자에 대한 안내','박지성','1234','사건 발생 경위 및 분석 진행 상황을 안내하는 공지를 진행하였습니다.',now(),6666,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('SE검색 서비스 종료 안내문','메시','1234','SE 검색서비스가 2017년 3월 27일자로 종료할 예정입니다.',now(),5555,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('미술검색 서비스 지식백과 통합 운영 안내','네이마르','1234','그런데 미술작품을 제대로 이해하기 위해서는 고화질 이미지 감상과 더불어 충분한 해설 정보가 필요하다고 판단되어 지식백과 서비스와 통합 운영하기로 결정하였습니다.',now(),3333,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('공정위 동의의결에 따른 키워드광고 등 표시방법 변경 안내','오라클','1234','공정거래위원회 동의의결에 의한 키워드광고 등 표시방식 변경을 알려 드립니다.',now(),3333,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('돌잔치/청첩장 초대장을 사칭한 스미싱 관련 주의 안내','자바','1234','돌잔치/청첩장 초대장을 사칭한 스미싱에 대해 안내 드립니다.',now(),2222,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('사명 변경에 대해 알려드립니다.','CSS','1234','사명 변경에 대해 알려드립니다.',now(),1111,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('주민등록번호 수집 · 이용 제한 제도 시행에 따른 안내','HTML','1234','주민등록번호 수집•이용 제한 제도 시행에 따른 안내 말씀 드립니다.',now(),900,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('2012년 제18대 대선 특집 페이지 안내','JSP','1234','2012년 제 18대 대선 특집 페이지 오픈에 대한 안내 말씀 드립니다.',now(),800,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('파란닷컴 서비스 종료 관련 블로그 검색 안내','R','1234','파란닷컴 서비스 종료 관련 블로그 검색에 대한 안내 말씀 드립니다.',now(),777,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('해외증시 및 시장지표 일부 서비스 변경 사항 안내','스프링','1234','미국증시 지연시세 전환에 관한 안내 말씀 드립니다.',now(),777,0);
INSERT INTO VisinsaNotice (title,writer,pass,content,reg_date,hits,state) VALUES ('특정 IP에서의 아이디 도용 시도에 관한 안내','파이썬','1234','특정 IP에서의 아이디 도용 시도에 관한 안내 말씀 드립니다.',now(),10,0);
COMMIT;

SELECT * FROM VisinsaNotice ORDER BY no DESC;
SELECT * FROM VisinsaNotice ORDER BY (hits+0) DESC;

