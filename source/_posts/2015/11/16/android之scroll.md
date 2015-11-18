title: android之scroll
date: 2015-11-16 19:55:10
tags:
---
 前些日子在开发中用到了需要ScrollView嵌套GridView的情况，由于这两款控件都自带滚动条，当他们碰到一起的时候便会出问题，即GridView会显示不全。
解决办法，自定义一个GridView控件
```
public class MyGridView extends GridView {
    public MyGridView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public MyGridView(Context context) {
        super(context);
    }

    public MyGridView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    @Override
    public void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {

        int expandSpec = MeasureSpec.makeMeasureSpec(
                Integer.MAX_VALUE >> 2, MeasureSpec.AT_MOST);
        super.onMeasure(widthMeasureSpec, expandSpec);
    }
}
```
该自定义控件只是重写了GridView的onMeasure方法，使其不会出现滚动条，ScrollView嵌套ListView也是同样的道理，不再赘述。
XML布局代码
```
<ScrollView Android:layout_height="wrap_content"
        android:layout_width="fill_parent" android:id="@+id/scroll_content">
        <com.yourclass.MyGridView xmlns:android="http://schemas.android.com/apk/res/android"
            android:id="@+id/grid_view" android:layout_width="fill_parent"
            android:layout_height="wrap_content" android:numColumns="auto_fit"
            android:horizontalSpacing="1dip" android:verticalSpacing="1dip"
            android:columnWidth="150dip" android:stretchMode="columnWidth"
            android:gravity="center">
            
        </com.yourclass.MyGridView>
    </ScrollView>
```
Java调用代码
```
MyGridView gridview = (MyGridView) findViewById(R.id.grid_view); 
```




* scrollView 空白

	-	此方法无效
		```
		<?xml version="1.0" encoding="utf-8"?>
		<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
		    android:id="@+id/scrollView1"
		    android:layout_width="fill_parent"  // 关键设置
		    android:layout_height="fill_parent"  // 关键设置  不能用match_parent
		    android:fillViewport="true" 
		    android:layout_alignParentBottom="true" >
		    <LinearLayout
		        android:layout_width="match_parent"
		        android:layout_height="wrap_content"   // 关键设置
		        android:orientation="vertical" >
		    </LinearLayout>
		</ScrollView>
		```
	-	尝试zhong
		```
		
		很久以前发了一个问答贴，关于ScrollView里面嵌套了ListView导致高度无法计算的Bug，发现到现在也有很多朋友遇到这样的问题，在此整理下解决方法。
		
		1.此方法是国外牛人写的，只需要调用此方法就可以了，但是此方法有两个Bug，第一个就是Item的布局根标签必须是LinearLayout，第二个就是在Item里面如果TextView换行了以后高度也无法精确计算。代码如下：
		[mw_shl_code=java,true]/**
		         * 设置ListView高度自适应
		         * ListView item必须是LinearLayout
		         * 其他的Layout(如RelativeLayout)没有重写onMeasure()，所以会在onMeasure()时抛出异常
		         */
		        public static void setListViewHeightBasedOnChildren(Activity activity, int res) {
		                ListView listView = (ListView) activity.findViewById(res);
		                ListAdapter listAdapter = listView.getAdapter();
		                if (listAdapter == null) {
		                        // pre-condition
		                        return;
		                }
		                int totalHeight = 0;
		                for (int i = 0; i < listAdapter.getCount(); i++) {
		                        View listItem = listAdapter.getView(i, null, listView);
		                        listItem.measure(0, 0);
		                        totalHeight += listItem.getMeasuredHeight();
		                }
		                ViewGroup.LayoutParams params = listView.getLayoutParams();
		                params.height = totalHeight
		                                + (listView.getDividerHeight() * (listAdapter.getCount() - 1));
		                listView.setLayoutParams(params);
		        }[/mw_shl_code]
		
		2.重写ListView或GridView，使ListView失去滑动性，代码如下：
		[mw_shl_code=java,true]/**
		* ScrollView和LsitView嵌套后高度无法计算，所以重写ScrollView，使其失去滑动
		*/
		public class NoScrollListView extends ListView {
		        
		        public NoScrollListView(Context context, AttributeSet attrs) {
		                super(context, attrs);
		        }
		
		        public void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		                int mExpandSpec = MeasureSpec.makeMeasureSpec(Integer.MAX_VALUE >> 2,
		                                MeasureSpec.AT_MOST);
		                super.onMeasure(widthMeasureSpec, mExpandSpec);
		        }
		
		}[/mw_shl_code]
		```
	