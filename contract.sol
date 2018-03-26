pragma solidity ^0.4.19;
//pragma experimental ABIEncoderV2;
contract Tourist
{
        uint public a;
        uint public b=0;
        uint public c;
        uint public count=0;


        struct tourist{
        uint256 id;
        uint256 allowedBy;
        uint256 count1;
        uint256 count2;
        uint256 count3;
        uint256 count4;
        uint256 count5;
        uint256 peopleCount;
        uint256 time_stamp;
        }

        mapping(uint256 => tourist)tourist_map;
        mapping(uint256 => bool) waiting;
        mapping(uint256 => bool)public rewarded;


        function get2tourist(uint[] not_entered) public view returns(uint a){
            uint memcount=0;
            uint time=now;
            for(uint i=not_entered.length-1;i>=0;i--){
            if(tourist_map[not_entered[i]].time_stamp>= time-(30*60)){
                if(memcount<1)
                {
                    a= not_entered[i];
                    memcount++;
                }
            }
            }
        }

        function addTourist(uint _id , uint c1, uint c2,uint c3,uint c4,uint c5) public  {
            tourist_map[_id].id  = _id;
            tourist_map[_id].allowedBy = 0;
            tourist_map[_id].count1  =  c1 ;
            tourist_map[_id].count2  =  c2 ;
            tourist_map[_id].count3  =  c3 ;
            tourist_map[_id].count4  =  c4 ;
            tourist_map[_id].count5  =  c5 ;
            tourist_map[_id].time_stamp = now;
            tourist_map[_id].peopleCount=0;
            rewarded[_id]=false;
            waiting[_id]=true;
            count++;

        }

        function sendToUser(uint _id1) public view returns(uint,uint,uint,uint,uint,uint)
        {

            return (tourist_map[_id1].id,tourist_map[_id1].count1,tourist_map[_id1].count2,tourist_map[_id1].count3,tourist_map[_id1].count4,tourist_map[_id1].count5);

        }

        function getVerified(uint256 _id2, bool verify)
        {  if(tourist_map[_id2].peopleCount<5){
               if(verify){
                   tourist_map[_id2].allowedBy++;
                   b=tourist_map[_id2].allowedBy;
                   tourist_map[_id2].peopleCount++;
               }
               else
               {
                   tourist_map[_id2].peopleCount++;
               }
            }
        
            else
            {
                if(tourist_map[_id2].allowedBy>=3)
                {
                    rewarded[_id2]=true;
                    delete tourist_map[_id2];
                }
                else{
                rewarded[_id2]=false;
                delete tourist_map[_id2];
                }
            }
            c=tourist_map[_id2].peopleCount;
        }
        function willBeRewarded(uint _id3) public returns (bool)
        {
            return rewarded[_id3];
        }

}
