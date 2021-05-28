pragma solidity >=0.4.22 <0.8.0;

contract Election {

   struct Candidate { //후보자 정보 저장
       uint id;
       string name;
       uint voteCount;
   }

   //후보자 조회 및 불러오기
   mapping(uint => Candidate) public candidates;
   mapping(address => bool) public voters;

   uint public candidatesCount; // 후보자 득표수 저장
   uint lastUpdated = now;

   constructor() public {
       addCandidate("후보자1");
       addCandidate("후보자2");
       addCandidate("후보자3");
       addCandidate("후보자4");
   }

   event votedEvent (
          uint indexed _candidateId
      );

   function addCandidate (string memory _name) private { //후보자 추가 함수
       candidatesCount ++;
       candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
   }


   function vote (uint _candidateId) public {
     // 중복투표 방지 함수 , 한계정당 한번의 투표만 진행
     if( now <= (lastUpdated + 60 minutes)) {
       require(!voters[msg.sender], "");


       require(_candidateId > 0 && _candidateId <= candidatesCount, "");


       voters[msg.sender] = true;

       candidates[_candidateId].voteCount ++;

       emit votedEvent(_candidateId);
   }
 }

}
