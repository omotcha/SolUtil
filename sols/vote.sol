pragma solidity >=0.4.22<0.7.0;

/// original recipe https://learnblockchain.cn/docs/solidity/0.6.4/examples/voting.html
/// modified so that it works on solidity 0.6.4 and passes tests on remix evm

contract Vote{
    struct Voter{
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }

    struct Proposal{
        bytes32 name;
        uint voteCount;
    }

    address public chair;
    mapping(address=>Voter) private voters;
    Proposal[] public proposals;

    constructor(bytes32[] memory proposalNames) public {
        chair = msg.sender;
        voters[chair].weight = 1;
        for(uint i=0;i<proposalNames.length;i++){
            proposals.push(Proposal({name: proposalNames[i],voteCount: 0}));
        }
    }

    function getWeight(address voter) public view returns(uint weight){
        weight = voters[voter].weight;
    }

    function getRightsToVote(address voter) public {
        require(msg.sender == chair);
        require(!voters[voter].voted);
        require(voters[voter].weight == 0);
        Voter storage vo=voters[voter];
        vo.weight=1;
    }

    function delegateVote(address to) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted);
        require(to!=msg.sender);
        while(voters[to].delegate!=address(0)){
            to = voters[to].delegate;
            require(to!=msg.sender);
        }
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if(delegate_.voted){
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            delegate_.weight += sender.weight;
        }
    }

    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted);
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns(uint winningProposal_){
        uint winningCount = 0;
        winningProposal_ = 0;
        for(uint p=0;p<proposals.length;p++){
            if(proposals[p].voteCount > winningCount){
                winningCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    function winner() public view returns(bytes32 winnerName_){
        winnerName_ = proposals[winningProposal()].name;
    }
}