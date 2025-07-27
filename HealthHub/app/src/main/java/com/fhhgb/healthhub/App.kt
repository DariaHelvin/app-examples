package com.fhhgb.healthhub

import android.app.Application
import com.fhhgb.healthhub.utils.SharedPrefHelper

class App : Application() {
    val medicine = mutableListOf<String>()

    override fun onCreate() {
        super.onCreate()
        val sharedPrefHelper = SharedPrefHelper(this)
        medicine.addAll(sharedPrefHelper.getMedicineList())
    }
}
