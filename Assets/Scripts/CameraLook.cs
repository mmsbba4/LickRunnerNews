using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraLook : MonoBehaviour
{
    public Camera[] camera_list;
    public void SetCamera(int index)
    {
        foreach (var i in camera_list)
        {
            i.enabled = false;
        }
        camera_list[index].enabled = true;
    }
    public Transform player;
    public void Update()
    {

        transform.position = Vector3.Lerp(transform.position, player.position, Time.deltaTime * 10f);
  
        if (Input.GetKeyDown(KeyCode.Keypad2))
        {
            SetCamera(1);
        }
        if (Input.GetKeyDown(KeyCode.Keypad3) )
        {
            SetCamera(2);
        }
        if (Input.GetKeyDown(KeyCode.Keypad4) )
        {
            SetCamera(3);
        }
        if (Input.GetKeyDown(KeyCode.Keypad5) )
        {
            SetCamera(4);
        }
        if (Input.GetKeyDown(KeyCode.Keypad6) )
        {
            SetCamera(5);
        }
        if (Input.GetKeyDown(KeyCode.Keypad8) )
        {
            SetCamera(6);
        }
        if (Input.GetKeyDown(KeyCode.Keypad9) )
        {
            SetCamera(7);
        }
        if (Input.GetKeyDown(KeyCode.Keypad1) )
        {
            SetCamera(0);
        }
    }
}
