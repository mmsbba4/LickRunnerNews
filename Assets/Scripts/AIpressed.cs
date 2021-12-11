using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AIpressed : MonoBehaviour
{
    public AnimationCurve cur;
    float delta_press = 0f;
    public bool is_pressed;
    public float step = 0;
    private void Start()
    {
        step = Random.Range(1, 5);
    }
    void Update()
    {
        delta_press += Time.deltaTime;
        if(delta_press > step)
        {
            delta_press = 0;
            step = Random.Range(1,5);
            if (cur.Evaluate(Random.Range(0.1f, 1.0f)) < 0.5f)
            {
                is_pressed = true;
            }
            else
            {
                is_pressed = false;
            }
        }
    }
}
