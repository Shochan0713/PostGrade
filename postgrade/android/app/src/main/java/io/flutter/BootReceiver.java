package io.flutter;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import java.io.IOException;
import com.example.postgrade.MainActivity;

public class BootReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        System.err.println("BootReceiverの実行");
        if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) {
            // Node.js サーバーを起動するコマンドを定義
            String[] command = {"/data/data/com.termux/files/usr/bin/node", "/path/to/your/server.js"};

            try {
                // ProcessBuilder を使用して Node.js を起動
                ProcessBuilder processBuilder = new ProcessBuilder(command);
                processBuilder.start();
            } catch (IOException e) {
                e.printStackTrace();
            }

            // アプリのメインアクティビティを起動
            Intent i = new Intent(context, MainActivity.class);
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(i);
        }
   
    }
}
