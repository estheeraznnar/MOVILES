package org.iesch.app07

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.os.bundleOf
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.fragment.app.add
import androidx.fragment.app.commit
import org.iesch.app07.fragments.ADRESS_BUNDLE
import org.iesch.app07.fragments.NAME_BUNDLE
import org.iesch.app07.fragments.PrimerFragment

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        //3-
        val bundle = bundleOf(
            NAME_BUNDLE to "Esther",
            ADRESS_BUNDLE to "mi casa"
        )

        //2-
        supportFragmentManager.commit {
            setReorderingAllowed(true)//Esto siempre
            add<PrimerFragment>(R.id.fragmentContainer, args = bundle)
        }
    }
}