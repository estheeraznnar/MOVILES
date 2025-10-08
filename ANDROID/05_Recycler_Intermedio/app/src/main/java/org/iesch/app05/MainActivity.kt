package org.iesch.app05

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.recyclerview.widget.LinearLayoutManager
import org.iesch.app05.adapter.AndroidVersionAdapter
import org.iesch.app05.databinding.ActivityMainBinding
import org.iesch.app05.provider.AndroidVersionProvider

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private lateinit var  adapter: AndroidVersionAdapter
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        initRecycleView()

    }

    private fun initRecycleView() {
        //obtenemos la lista de versiones android
        val versionesAndroid = AndroidVersionProvider.androidVersionsList
        adapter = AndroidVersionAdapter(versionesAndroid)

        //configurar recyclerview usando binding
        binding.rvVersionesAndroid.layoutManager = LinearLayoutManager(this)
        binding.rvVersionesAndroid.adapter = adapter
    }
}