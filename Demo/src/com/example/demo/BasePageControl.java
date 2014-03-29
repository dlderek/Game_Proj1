package com.example.demo;

import android.util.Log;
import android.view.View;

public class BasePageControl {
	protected View Page;
	public BasePageControl(View _Page) {
		Page = _Page;
		Log.d("Construct Page Control", Page.toString());
	}

}
