use spring;

# 테이블 생성
DROP TABLE IF EXISTS reply;
DROP TABLE IF EXISTS community;
CREATE TABLE IF NOT EXISTS community(

	no INTEGER AUTO_INCREMENT PRIMARY KEY,
	id VARCHAR(500) NOT NULL,
	category VARCHAR(900) NOT NULL,
	title VARCHAR(4000) NOT NULL,
	content VARCHAR(5000) NOT NULL,
	medic int NOT NULL,
	regdate TIMESTAMP DEFAULT NOW() NOT NULL,
	readcount int NOT NULL,
    recommend INTEGER default 0 NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

# 자유게시판 글
INSERT INTO community (id, category, title, content, medic, regdate, readcount) VALUES('bktest01', 'board', '안녕하세요, 오늘 가입했습니다.', '잘부탁드려요 ^_^', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'board', '저녁엔 저염식~^^', '건강들 챙깁시다 ~~', '2', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'board', '오늘 새로 생긴곳이군요~~ 잘지내봐요 !', '이쁘게 잘 꾸며나가요 ~~', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'board', '안녕하세요, 오늘 가입했습니다.', '잘부탁드려요 ^_^', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'board', '여기가 자유게시판인가요 ??', '사람들 좀 있나요 ??', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'board', '오래된 약은 드시지마시고 폐기하세요...ㅠㅠ', '잘못되면 큰일납니다 !!', '2', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'board', '빨리 출근하고 싶어요 !!', '사장님이 잘해주셔서 일 하러가는게 행복해요 !', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'board', '모두들 식사는 하셨나요~~', '저는 부대찌개 먹었습니다 !!', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'board', '흡연은 만병의 근원입니다.', '모두들 금연 해봅시다~!! 화이팅 !', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'board', '금연할때 보조제를 사용해보세요', '훨씬 쉬워진답니다~~~~', '1', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'board', '요즘 날씨가 점점 더워집니다..', '다들 건강 유의하세요~~', '2', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'board', '요즘 미세먼지 너무 심해요 !!', '중국발 영향이 크다고 알고있는데 참... 답이 없습니다 !!', '1', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'board', '그래도 요즘은 마스크 구하기가 쉽네요~~', '그나마 다행입니다 !!', '1', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'board', '다이어트 실패ㅠㅠ', '하..식욕억제하기 너무 힘드네요 참..', '1', now(), 0);


# qna게시판 글
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'qna', '동물관련 질문있습니다 !', '일반 약국에는 동물이 먹는 약을 파나요 ??', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'qna', '알레르기 비염 너무 심합니다ㅠㅠ', '부작용 없는 약 좀 없을까요 ??', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'qna', '콧물이 자꾸만나와요...', '감기는 아니라는데.. 왜그럴까요 ??', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'qna', '사이트 이용하시면서 불편하신 점 있으셨던분 ?', '저는 가끔 접속이 안됩니다.. 같은 증상 있으신분 계신가요 ??', '1', now(), 2);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'qna', '천식인데 호흡기 사용안해도될까요..?', '한달에 한번정도 숨쉬기 힘든데 그 외에는 괜찮습니다. 호흡기 그만 달고다녀도되나요 ??', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'qna', '허리가 자주 쑤십니다.. 이거 디스크 증상인가요 ?', '제곧내', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'qna', '밥먹고 졸음이 너무 심하게와요.. 병원 가봐야하나요 ??', '점심에 식곤증이 너무심합니다...ㅠㅠ해결방법 없습니까??', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'qna', '코로나19 검사받는게 안전한건가요 ??', '음성이던 사람도 그 사람많은곳에서 양성되서 나올것같아요...무섭습니다..ㅠㅠ', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'qna', '몸 안에 노폐물을 배출시켜주는 약 좋은거 좀 있을까요 ??', '찾아봐도 잘 없어서 질문합니다~~', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'qna', '코피가 너무 자주납니다.. 피로문제인가요 코 문제인가요 ??', '통증은 없습니다.', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest01', 'qna', '편의점에서 구매가능한 약은 어떤게 있나요 ??', '상비약이라고는 하는데 구체적으로 알고싶습니다 ~~', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'qna', '허가되지 않은 의약품인지 확인하는 방법이 뭐가있나요 ??', '요즘엔 뭐든 조심하고 먹고 해야할것같아서 여쭤봅니다 !', '0', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'qna', '아들이 키가 안커요... 영양부족일까요 ??', '또래들보다 5~8cm는 작습니다 해결방법 없나요 ㅠㅠ', '1', now(), 0);


# 영양제 및 의약품 추천 게시판
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'chuchu', '알레르기 비염에 좋은 약 추천합니다 !!', '약이름 : 액티피드 입니다 ~~ 다만 ! 졸음이 많이오니 조심 !', '2', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'chuchu', '금연하시는 분들을 위한 보조제 추천해요~', '니코틴엘 이라는건데요 ~~ 패치로 되어있어 사용이 편합니다 !! 강추~!!', '2', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'chuchu', '두통 및 해열제의 정석.', '다들 아실겁니다~~ 타이레놀 ! 다만 과다복용 및 오용은 건강에 문제가 될 수 있습니다 !', '1', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'chuchu', '코감기 및 코막힘 의약품 추천드려요 ~~', '니코틴엘 이라는건데요 ~~ 패치로 되어있어 사용이 편합니다 !! 강추~!!', '1', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'chuchu', '잠 안오는 비염약 !', '클리어딘 이라는 약입니다~~ 비염약이지만 졸음 부작용이 없어요~~', '2', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'chuchu', '프로바이오틱스(유산균) 영양제 추천합니다.', '듀오락 골드 입니다~~ 한달 분 6~7만원 정도로 좀 비싼편이지만 좋은 균주들을 사용한 좋은 약입니다 !', '2', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'chuchu', '여성 멀티비타민 추천~~', '유기농 성분이라 믿고 먹을 수 있습니다~ 자세한 성분은 인터넷 검색~~^^', '2', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest03', 'chuchu', '금연하시는 분들을 위한 보조제 추천해요~', '니코틴엘 이라는건데요 ~~ 패치로 되어있어 사용이 편합니다 !! 강추~!!', '2', now(), 0);
INSERT INTO community (id, category, title, content, medic, regdate, readcount)  VALUES('bktest02', 'chuchu', '칼슘 영양제 이거 좋아욤!!', '가든오브라이프 유기농 원료 칼슘 ~~ 미국 판매 1위라고하네요 필요하신분 있으실까해서 추천드립니다 ㅎㅎ', '2', now(), 0);


DROP TABLE IF EXISTS reply;
CREATE TABLE IF NOT EXISTS reply(
	no INTEGER AUTO_INCREMENT PRIMARY KEY,
	bbs_no INTEGER NOT NULL,
	reply_content VARCHAR(500) NOT NULL,
	replyid VARCHAR(20) NOT NULL,
	replydate TIMESTAMP NOT NULL,	
    replyrecommend INTEGER default 0 NOT NULL,
    replymedic INTEGER,
    replybusinessName VARCHAR(500),
    replybusinessAdd VARCHAR(1000)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 댓글 데이터 추가하기 - 1번만 실행한다. --
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(7, '항상 감사합니다.\r\n땡큐!~', 'bktest01', '2016-05-08 13:44:32');
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(7, '저두 감사드립니다.', 'bktest03', '2018-01-09 05:24:57', 2);
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(7, '저두요~ ^_^', 'bktest01', '2018-01-09 09:19:23');
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(1, '헤헷~ 감사 합니다.', 'bktest01', '2018-01-09 12:16:51');
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(7, '저두 사이트 발전에 관심이 많습니다.\r\n감사합니다.' , 'bktest03', '2018-01-09 14:39:29', 2);
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(7, '와~ 대단하네요 우리 사이트~\r\nㅋㅋㅋ~', 'bktest02', '2018-01-09 14:41:18', 1);
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(7, '항상 감사합니다.', 'bktest03', '2018-01-15 16:19:23', 2);
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(7, '땡큐!~', 'bktest01', '2018-01-16 17:31:45');
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(1, '저두요~ 땡큐!~', 'bktest02', '2018-01-19 18:16:51', 1);
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(1, '땡큐~ 여기 붙어라~ ^_^', 'bktest01', '2018-01-20 11:33:27');
INSERT INTO reply(bbs_no, reply_content, replyid, replydate, replymedic)VALUES(1, '땡큐~ 붙었어요~', 'bktest01', '2018-01-20 13:19:59');

commit;
SELECT * FROM community;
SELECT * FROM reply;
SELECT * FROM member;
