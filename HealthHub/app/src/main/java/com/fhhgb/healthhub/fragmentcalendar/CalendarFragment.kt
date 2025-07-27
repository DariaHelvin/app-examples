package com.fhhgb.healthhub.fragmentcalendar

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.fhhgb.healthhub.databinding.FragmentCalendarBinding

class CalendarFragment : Fragment() {

    private lateinit var binding: FragmentCalendarBinding

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentCalendarBinding.inflate(layoutInflater, container, false)
        return binding.root
    }

    override fun onResume() {
        super.onResume()
        val adapterVisit = VisitAdapter()
        binding.recyclerView2.layoutManager = LinearLayoutManager(
            requireContext(),
            LinearLayoutManager.VERTICAL,
            false
        )
        binding.recyclerView2.adapter = adapterVisit


        binding.calendarView2.setOnDateChangeListener { view, year, month, dayOfMonth ->
            when {
                year == 2024 && month == 5 && dayOfMonth == 18 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[0]))
                }

                year == 2024 && month == 5 && dayOfMonth == 2 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[1]))
                }

                year == 2024 && month == 5 && dayOfMonth == 17 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[2]))
                }

                year == 2024 && month == 6 && dayOfMonth == 17 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[3]))
                }

                year == 2024 && month == 6 && dayOfMonth == 1 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[4]))
                }

                year == 2024 && month == 6 && dayOfMonth == 3 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[5]))
                }

                year == 2024 && month == 6 && dayOfMonth == 5 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[6]))
                }

                year == 2024 && month == 6 && dayOfMonth == 8 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[7]))
                }

                year == 2024 && month == 6 && dayOfMonth == 10 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[8]))
                }

                year == 2024 && month == 6 && dayOfMonth == 12 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[9]))
                }

                year == 2024 && month == 6 && dayOfMonth == 15 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[10]))
                }

                year == 2024 && month == 6 && dayOfMonth == 17 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[11]))
                }

                year == 2024 && month == 6 && dayOfMonth == 19 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[12]))
                }

                year == 2024 && month == 6 && dayOfMonth == 22 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[13]))
                }

                year == 2024 && month == 6 && dayOfMonth == 24 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[14]))
                }

                year == 2024 && month == 6 && dayOfMonth == 26 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[15]))
                }

                year == 2024 && month == 6 && dayOfMonth == 29 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[16]))
                }

                year == 2024 && month == 6 && dayOfMonth == 31 -> {
                    adapterVisit.updateDataset(listOf(VisitList.visits[17]))
                }

                else -> {
                    adapterVisit.updateDataset(emptyList())
                }
            }
        }
    }

    companion object {
        @JvmStatic
        fun newInstance() = CalendarFragment()
    }
}