
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class UiamModel{

  final String _rpcUrl="https://rinkeby.infura.io/v3/686c28cc4041426aaf2e8d65d9c36aad";
  final String _wsUrl="wss://rinkeby.infura.io/ws/v3/686c28cc4041426aaf2e8d65d9c36aad";
  final String _privatekey="f5272ad04eb5a8e2766742f35fa9d5a825de20cd312370bf76ded2bbfde7ead8";
  final String _contractRedix = "0x4e4ab4B8355c08e590b2D409eaC66C38f27f5798";
  late Web3Client _client;
  String _abiCode="";
  late EthPrivateKey _credentials;
  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddress;
  late DeployedContract _contract;
  late ContractFunction _isVerfied;
  late ContractFunction _createUser;
   late ContractFunction _check;
 // late ContractEvent _taskCreatedEvent;

  Future<void> getAbi() async{
    var abiStringfile = await rootBundle.loadString("src/abis/UiamContract.json");
    
    var jsonAbi = const JsonDecoder().convert(abiStringfile);

    _abiCode = jsonEncode(jsonAbi['abi']);
    _contractAddress = EthereumAddress.fromHex(_contractRedix);
    print(_contractAddress);
    
  }



  initialSetup() async{
    _client=Web3Client(
      _rpcUrl,
      Client(),
      socketConnector: (() {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      }
      ));

    await getAbi();
   await getCredentials();
   await getDeployedContract();
  }


    Future<void> getCredentials() async {
   // _credentials = await _client.credentialsFromPrivateKey(_privatekey);
   _credentials =  EthPrivateKey.fromHex(_privatekey);
    _ownAddress = await _credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "UiamContract"), _contractAddress);
    _createUser = _contract.function("Create");
    _isVerfied = _contract.function("find");
    _check = _contract.function("isVerfied");
  }

//CHECK IF USER IS VERIFIED WITH BLOCKCHAIN
  checkAuth(uid,hashUid) async {
    await initialSetup();
    var hash =    await _client.sendTransaction(_credentials, Transaction.callContract(contract: _contract, function: _isVerfied, parameters: [uid,hashUid]),chainId: 4);
    
    var checkValidity = await _client.call(contract: _contract, function:_check, params: []);
     print("user checked");
     print(checkValidity[0]);
  }
//ADD USER TO BLOCKCHAIN
  addUser(uid,hashUid) async 
  {
    await initialSetup();
    var hash = await _client.sendTransaction(_credentials, Transaction.callContract(contract: _contract, function: _createUser, parameters: [uid,hashUid]),chainId: 4);
    print("user added");
  }
}

