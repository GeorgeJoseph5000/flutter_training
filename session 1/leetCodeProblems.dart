// https://leetcode.com/problems/longest-common-prefix/
String longestCommonPrefix(List<String> strs) {
    if (strs.isEmpty) {
        return "";
    }
    String prefix = strs[0];
    for (var element in strs) {

        while (element.indexOf(prefix) != 0) {
        prefix = prefix.substring(0, prefix.length - 1);
        if (prefix.isEmpty) {
            return "";
        }
        }

    }
    return prefix;
}


// https://leetcode.com/problems/decode-the-message/
String decodeMessage(String key, String message) {
    final List<String> alphabet = "abcdefghijklmnopqrstuvwxyz".split("");
    final List<String> keys = key.split("");
    final List<String> keysValidated = [];
    for (var element in keys) {
        if(!keysValidated.contains(element) && element != " " && keysValidated.length < alphabet.length){
        keysValidated.add(element);
        }
    }
    final List<String> messageList= message.split("");
    List<String> decodedMessageList = [];
    for (var element in messageList) {
        if(element != " "){
        var indexInAlphabet = keysValidated.indexOf(element);
        decodedMessageList.add(alphabet[indexInAlphabet]);
        }else{
        decodedMessageList.add(" ");
        }
    }
    return decodedMessageList.join();
}

// https://leetcode.com/problems/maximum-number-of-words-found-in-sentences/
int mostWordsFound(List<String> sentences) {
    var previousLength = 0;
    for (var sentence in sentences){
        var length = sentence.split(" ").length;
        if(previousLength < length){
            previousLength = length;
        }
    }
    return previousLength;
}

// https://leetcode.com/problems/palindrome-number/description/
bool isPalindrome(int x) {
    if (x < 0) {
        return false;
    }
    int reverse = 0;
    int temp = x;
    while (temp > 0) {
        reverse = reverse * 10 + temp % 10;
        temp = temp ~/ 10;
    }
    return reverse == x;
}

// https://leetcode.com/problems/two-sum/
List<int> twoSum(List<int> nums, int target) {
    for (int i = 0; i < nums.length; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] == target) {
                return [i, j];
            }
        }
    }
    return [];
}

// https://leetcode.com/problems/integer-to-roman/

String intToRoman(int num) {
    final List<String> thousands = ['', 'M', 'MM', 'MMM'];
    final List<String> hundreds = ['', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM'];
    final List<String> tens = ['', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC'];
    final List<String> ones = ['', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX'];
    return thousands[num ~/ 1000] + hundreds[num % 1000 ~/ 100] + tens[num % 100 ~/ 10] + ones[num % 10];
}

// https://pastebin.com/68k0Sb43
