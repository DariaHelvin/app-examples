package com.fhhgb.healthhub.fragmentcalendar

import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.fhhgb.healthhub.databinding.RecycleViewItemBinding

class VisitViewHolder(private val binding: RecycleViewItemBinding): ViewHolder(binding.root) {
    fun setData(visit: Visit){
        binding.dayOfWeek.text = visit.dayOfWeek
        binding.daySlot.text = visit.date
        binding.visitSlot.text = visit.visitSlot
    }
}