package com.fhhgb.healthhub

import android.os.Bundle
import android.view.Menu
import android.view.MenuInflater
import android.view.MenuItem
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.MenuProvider
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.fhhgb.healthhub.databinding.ActivityHomeScreenBinding
import com.fhhgb.healthhub.fragmentcalendar.CalendarFragment
import com.fhhgb.healthhub.fragmentmedicine.MedicineScreen

class HomeScreen : AppCompatActivity() {

    private lateinit var binding: ActivityHomeScreenBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityHomeScreenBinding.inflate(layoutInflater)

        enableEdgeToEdge()
        setContentView(binding.root)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        setSupportActionBar(binding.toolbar)
        binding.toolbar.title = ""
        supportActionBar?.setDisplayShowTitleEnabled(false)
        addMenuProvider(object : MenuProvider {
            override fun onCreateMenu(menu: Menu, menuInflater: MenuInflater) {
                menuInflater.inflate(R.menu.toolbar, menu)
            }

            override fun onMenuItemSelected(menuItem: MenuItem): Boolean {
                return when (menuItem.itemId) {
                    R.id.account_icon -> { // navigate to account settings (under development)

                        true
                    }

                    else -> false
                }
            }
        })

        binding.bottomNavigation.setOnItemSelectedListener { menuItem ->
            when (menuItem.itemId) {
                R.id.navigation_home -> {
                    supportFragmentManager
                        .beginTransaction()
                        .replace(binding.fragmentContainer.id, CalendarFragment.newInstance())
                        .addToBackStack("Calendar")
                        .commit()
                    true
                }

                R.id.navigation_fullcalendar -> {
                    // navigate to full calendar fragment (under development)
                     true
                }

                R.id.navigation_medicine -> {
                    supportFragmentManager
                        .beginTransaction()
                        .replace(binding.fragmentContainer.id, MedicineScreen.newInstance())
                        .addToBackStack("Medicine")
                        .commit()
                    true
                }

                R.id.navigation_health -> {
                    // navigate to health fragment (under development)
                    true
                }

                else -> false
            }
        }


        if (savedInstanceState == null) {
            supportFragmentManager
                .beginTransaction()
                .replace(binding.fragmentContainer.id, CalendarFragment.newInstance())
                .commit()
        }
    }
}
