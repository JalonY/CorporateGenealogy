import org.junit.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: yjl
 * @date: 2018/5/24
 */
public class test {

    @Test
    public void test() {
        List<User> userList = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            User user = new User();
            user.setName("A" + i);
            user.setClasses("A");
            userList.add(user);
        }
        for (int i = 0; i < 10; i++) {
            User user = new User();
            user.setName("B" + i);
            user.setClasses("B");
            userList.add(user);
        }
        for (int i = 0; i < 10; i++) {
            User user = new User();
            user.setName("C" + i);
            user.setClasses("C");
            userList.add(user);
        }

        // 去重
        Map<String, Integer> classMap = new HashMap();
        for (User user : userList) {
            classMap.put(user.getClasses(), 0);
        }

        Map<String, List<User>> sortedUserMap = new HashMap<>();
        for (Map.Entry<String, Integer> entry : classMap.entrySet()) {
            String classes = entry.getKey();
            List<User> sortedUserList = new ArrayList<>();
            for (User user : userList) {
                if (user.getClasses().equals(classes)) {
                    sortedUserList.add(user);
                }
            }
            sortedUserMap.put(classes, sortedUserList);
        }

        List<List<String>> newList = new ArrayList();
        for (Map.Entry<String, List<User>> entry : sortedUserMap.entrySet()) {
            List<User> listUser = entry.getValue();
            List<String> userName = new ArrayList();
            for (User users: listUser){
                System.out.println(users.getName());
                userName.add(users.getName());

            }
            newList.add(userName);
        }

        System.out.println(newList.toString());
    }



    public String testString (String str){
        if(str == null || str.length() <= 1)
            return str;
        return testString(str.substring(1)) + str.charAt(0);
    }

    @Test
    public void testUpMethod(){
        System.out.println(testString("testString"));
    }
}
