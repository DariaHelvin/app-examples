package com.fhhgb.healthhub.fragmentmedicine

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import com.fhhgb.healthhub.databinding.FragmentMedicineScreenBinding
import com.fhhgb.healthhub.fragmentcalendar.MedicineAdapter
import com.fhhgb.healthhub.utils.SharedPrefHelper

class MedicineScreen : Fragment() {

    private lateinit var binding: FragmentMedicineScreenBinding
    private lateinit var sharedPrefHelper: SharedPrefHelper

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        sharedPrefHelper = SharedPrefHelper(requireContext())
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentMedicineScreenBinding.inflate(layoutInflater, container, false)
        return binding.root
    }

    override fun onResume() {
        super.onResume()
        val adapterMedicine = MedicineAdapter { medicine ->
            removeMedicine(medicine)
        }
        binding.fragmentMedicineScreen.layoutManager = LinearLayoutManager(
            requireContext(),
            LinearLayoutManager.VERTICAL,
            false
        )

        binding.fragmentMedicineScreen.adapter = adapterMedicine
        val medicineList = sharedPrefHelper.getMedicineList()
        adapterMedicine.updateDataset(medicineList)

        val inputField = binding.medicineInput
        val medicineButton = binding.fab

        medicineButton.setOnClickListener {
            val newMedicine = inputField.text.toString()
            if (newMedicine.isNotBlank()) {
                val updatedList = adapterMedicine.differ.currentList + newMedicine
                adapterMedicine.updateDataset(updatedList)
                sharedPrefHelper.saveMedicineList(updatedList)
                inputField.text?.clear()
            }
        }
    }

    private fun removeMedicine(medicine: String) {
        val currentList = sharedPrefHelper.getMedicineList().toMutableList()
        currentList.remove(medicine)
        sharedPrefHelper.saveMedicineList(currentList)
        (binding.fragmentMedicineScreen.adapter as MedicineAdapter).updateDataset(currentList)
    }

    companion object {
        @JvmStatic
        fun newInstance() = MedicineScreen()
    }
}
