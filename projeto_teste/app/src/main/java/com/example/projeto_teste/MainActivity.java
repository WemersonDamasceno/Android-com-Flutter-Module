package com.example.projeto_teste;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Button;
import io.flutter.embedding.android.FlutterActivity;


public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button myButton = findViewById(R.id.myButton);

        myButton.setOnClickListener(v -> startActivity(
                FlutterActivity.createDefaultIntent(getApplicationContext())
        ));

    }
}